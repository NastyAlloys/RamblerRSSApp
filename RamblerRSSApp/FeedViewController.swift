//
//  FeedViewController.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 2/2/16.
//  Copyright © 2016 Andrey Egorov. All rights reserved.
//

import UIKit
import MediaRSSParser
import AFNetworking

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // MARK: Instance Variables
    
    let parser = RSSParser()
    let cellIdentifier = "FeedCell"
    let imageCellIdentifier = "ImageCell"
    var selectedIndexPath: NSIndexPath?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    let urlDict = [
        "http://www.gazeta.ru/export/rss/lenta.xml",
        "http://lenta.ru/rss"
    ]
    
    var items: [RSSItem] = []
    
    var channels: [RSSChannel] = []
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        parseForQuery("")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        configureTableView()
        refreshData()
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        deselectAllRows()
    }
    
    func deselectAllRows() {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            for indexPath in selectedRows {
                tableView.deselectRowAtIndexPath(indexPath, animated: false)
            }
        }
    }
    
    // MARK: Refresh Content
    
    func refreshData() {
        searchTextField.resignFirstResponder()
        parseForQuery(searchTextField.text)
    }
    
    func reloadTableViewContent() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
            self.tableView.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: false)
        })
    }
    
    func parseForQuery(query: String?) {
        
        let count = urlDict.count
        
        var i = 0
        
            parser.parseRSSFeed(urlDict[i],
                parameters: parametersForQuery(query),
                success: {(let channel: RSSChannel!) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.convertItemPropertiesToPlainText(channel.items as! [RSSItem])
                        self.items += (channel.items as! [RSSItem])
                        self.channels.append(channel)
                        
                        if count > 1  {
                            i++
                            while i < count {
                                self.parser.parseRSSFeed(self.urlDict[i],
                                    parameters: self.parametersForQuery(query),
                                    success: {(let channel: RSSChannel!) -> Void in
                                        self.convertItemPropertiesToPlainText(channel.items as! [RSSItem])
                                        self.items += (channel.items as! [RSSItem])
                                        self.channels.append(channel)
                                        self.reloadTableViewContent()
                                    },
                                    failure: {(let error:NSError!) -> Void in
                                        //                self.hideProgressHUD()
                                        print("Error: \(error)")
                                        return
                                })
                                i++
                            }
                        } else {
                            self.reloadTableViewContent()
                        }
                    })
    //                self.hideProgressHUD()
                    
                }, failure: {(let error:NSError!) -> Void in
                    //                self.hideProgressHUD()
                    print("Error: \(error)")
                    return
            })
    }
    
//    func showProgressHUD() {
//        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
//        hud.labelText = "Loading"
//    }
    
    func parametersForQuery(query: NSString?) -> [String: String] {
        if query != nil && query!.length > 0 {
            return ["q": "\(query!)"]
        } else {
            return ["q": ""]
        }
    }
    
//    func hideProgressHUD() {
//        MBProgressHUD.hideAllHUDsForView(view, animated: true)
//    }
    
    func convertItemPropertiesToPlainText(rssItems:[RSSItem]) {
        for item in rssItems {
            let charSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()
            
            if let title = item.title as NSString! {
                item.title = title.stringByConvertingHTMLToPlainText().stringByTrimmingCharactersInSet(charSet)
            }
            
            /*if let mediaDescription = item.mediaDescription as NSString! {
                
                item.mediaDescription = mediaDescription.stringByConvertingHTMLToPlainText().stringByTrimmingCharactersInSet(charSet)
            }
            
            if let mediaText = item.mediaText as NSString! {
                                        print("text: \(mediaText)")
                item.mediaText = mediaText.stringByConvertingHTMLToPlainText().stringByTrimmingCharactersInSet(charSet)
            }*/
        }
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print(self.channels)
        if hasImageAtIndexPath(indexPath) {
            return imageCellAtIndexPath(indexPath)
        } else {
            return feedCellAtIndexPath(indexPath)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        var indexPaths : Array<NSIndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        }

    }
    
    /*func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
       
        let currentCell = hasImageAtIndexPath(indexPath) ?
            tableView.cellForRowAtIndexPath(indexPath)! as! ImageCell :
            tableView.cellForRowAtIndexPath(indexPath)! as! FeedCell
        
        currentCell.subtitleLabel.hidden = true
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

    }*/
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let selectedIndexPath = selectedIndexPath {
            if selectedIndexPath.row == indexPath.row {
                return 165
            }
        }
        
        return hasImageAtIndexPath(indexPath) ? 120.0 : 100.0
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height: CGFloat?
        
        if isLandscapeOrientation() {
            height = hasImageAtIndexPath(indexPath) ? 140.0 : 120.0
        } else {
            height = hasImageAtIndexPath(indexPath) ? 235.0 : 155.0
        }
        
        /*if self.selectedIndexPath != nil && selectedIndexPath!.row == indexPath.row {
            height = height! * 1.5
        }*/
        
        return height!
    }
    
    func isLandscapeOrientation() -> Bool {
        return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)
    }
    
    func feedCellAtIndexPath(indexPath: NSIndexPath) -> FeedCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! FeedCell
        setTitleForCell(cell, indexPath: indexPath)
        setSubtitleForCell(cell, indexPath: indexPath)
        return cell
    }
    
    func setTitleForCell(cell: FeedCell, indexPath: NSIndexPath) {
        let item = items[indexPath.row] as RSSItem
        cell.titleLabel.text = item.title ?? "[No Title]"
    }
    
    func setSubtitleForCell(cell: FeedCell, indexPath: NSIndexPath) {
        if self.selectedIndexPath != nil {
            cell.subtitleLabel.hidden = false
        } else {
            cell.subtitleLabel.hidden = true
        }
        
        let item = items[indexPath.row] as RSSItem
        var subtitle: NSString?
        
        if let description = item.itemDescription as NSString! {
            subtitle = description.stringByConvertingHTMLToPlainText().stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
        
        if let subtitle = subtitle {
            if subtitle.length > 200 {
                cell.subtitleLabel.text = "\(subtitle.substringToIndex(200))..."
            } else {
                cell.subtitleLabel.text = subtitle as String
            }
        } else {
            cell.subtitleLabel.text = ""
        }
    }
    
    func hasImageAtIndexPath(indexPath: NSIndexPath) -> Bool {
        let item = items[indexPath.row]
        let mediaThumbnailArray = item.mediaThumbnails as! [RSSMediaThumbnail]
        
        for mediaThumbnail in mediaThumbnailArray {
            if mediaThumbnail.url != nil {
                return true
            }
        }
        
        return false
    }
    
    func imageCellAtIndexPath(indexPath: NSIndexPath) -> ImageCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(imageCellIdentifier) as! ImageCell
        setImageForCell(cell, indexPath: indexPath)
        setTitleForCell(cell, indexPath: indexPath)
        setSubtitleForCell(cell, indexPath: indexPath)
        return cell
    }
    
    func setImageForCell(cell: ImageCell, indexPath: NSIndexPath) {
        let item: RSSItem = items[indexPath.row]
        
        var mediaThumbnail: RSSMediaThumbnail?
        
        if item.mediaThumbnails.count >= 2 {
            mediaThumbnail = item.mediaThumbnails[1] as? RSSMediaThumbnail
        } else {
            mediaThumbnail = (item.mediaThumbnails as NSArray).firstObject as? RSSMediaThumbnail
        }
        
        cell.customImageView.image = nil
        
        if let url = mediaThumbnail?.url {
            cell.customImageView.setImageWithURL(url)
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        refreshData()
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}