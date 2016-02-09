//
//  FeedListViewController.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 08/02/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

import UIKit
import MediaRSSParser
import AFNetworking

let cellIdentifier = "FeedCellIdentifier"

class FeedListViewController: UITableViewController {
    
//    var eventHandler : FeedListModuleInterface?
    var feedListPresenter: FeedListPresenter?
    var displayData: FeedListDisplayData?
    var selectedIndexPath: NSIndexPath?
    var previousIndexPath: NSIndexPath?
    var strongTableView: UITableView?
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        strongTableView = tableView
        configureView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        feedListPresenter?.updateView()
    }
    
    func configureView() {
        navigationItem.title = "RamblerRSSApp"
        
        let refreshItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("updateView"))
        
        navigationItem.rightBarButtonItem = refreshItem
    }
    
    func updateView() {
        feedListPresenter?.updateView()
    }
    
    func reloadData() {
        strongTableView!.reloadData()
    }
    
    func showUpcomingDisplayData(data: FeedListDisplayData) {
        view = strongTableView
        displayData = data
        reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = displayData?.items.count {
            return count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let selectedIndexPath = selectedIndexPath {
            if selectedIndexPath.row == indexPath.row {
                return 200
            }
        }
        
        return 120.0
    }
    
    func lineCount(label: UILabel) -> Int {
        var lines = 0;
        let constraint: CGSize = CGSizeMake(label.bounds.size.width, CGFloat.max)
        let size: CGRect = label.text!.boundingRectWithSize(constraint, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: label.font], context: nil)
        lines = max(Int(size.height / label.font.lineHeight), 0)
        
        return lines
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let feedItem = displayData?.items[indexPath.row]
        var subtitle: NSString?
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = feedItem!.title ?? "[No Title]"
        
        if indexPath == selectedIndexPath {
            cell.textLabel!.numberOfLines = 0
            cell.detailTextLabel!.hidden = false
            
            if let description = feedItem!.itemDescription as NSString! {
                subtitle = description.stringByConvertingHTMLToPlainText().stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            }
            
            if let subtitle = subtitle {
                if subtitle.length > 200 {
                    cell.detailTextLabel!.text = "\(subtitle.substringToIndex(200))..."
                } else {
                    cell.detailTextLabel!.text = subtitle as String
                }
            } else {
                cell.detailTextLabel!.text = ""
            }
        } else {
            let numberOfLines = lineCount(cell.textLabel!)
            cell.textLabel!.numberOfLines = numberOfLines
            cell.detailTextLabel!.hidden = true
            cell.detailTextLabel!.text = ""
        }
        
//        var mediaThumbnail: RSSMediaThumbnail?
//        
//        if feedItem!.mediaThumbnails.count >= 2 {
//            mediaThumbnail = feedItem!.mediaThumbnails[1] as? RSSMediaThumbnail
//        } else {
//            mediaThumbnail = (feedItem!.mediaThumbnails as NSArray).firstObject as? RSSMediaThumbnail
//        }
//        
//        cell.imageView!.image = nil
//        
//        if let url = mediaThumbnail?.url {
//            cell.imageView!.setImageWithURL(url)
//        }
        
//        var mediaThumbnail: RSSMediaThumbnail?
//        
//        let mediaThumbnailArray = feedItem!.mediaThumbnails as! [RSSMediaThumbnail]
//        
//        for mediaThumbnail in mediaThumbnailArray {
//            if mediaThumbnail.url != nil {
//                if feedItem!.mediaThumbnails.count >= 2 {
//                    mediaThumbnail = feedItem.mediaThumbnails[1] as? RSSMediaThumbnail
//                } else {
//                    mediaThumbnail = (feedItem.mediaThumbnails as NSArray).firstObject as? RSSMediaThumbnail
//                }
//            }
//        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) -> Void {
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        var indexPaths : [NSIndexPath] = []
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
    
}
