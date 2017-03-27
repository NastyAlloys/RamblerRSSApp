//
//  FeedListDataManager.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 2/8/16.
//  Copyright © 2016 Andrey Egorov. All rights reserved.
//

import Foundation
import MediaRSSParser

class FeedListDataManager: NSObject {
    
    let parser = RSSParser()
    var urlPos: Int = 0
    var count: Int = 0
    
    func fetchFeeds(urls: [String], completionHandler: ([RSSItem]?, NSError?) -> ()) {
        urlPos = 0
        let items: [RSSItem] = []
        parseRSSFeeds(urls, items: items, completionHandler: completionHandler)
    }
    
    func parseRSSFeeds(urls: [String], var items: [RSSItem], completionHandler: ([RSSItem]?, NSError?) -> ()) {
        let count = urls.count
        
        parser.parseRSSFeed(urls[urlPos],
            parameters: nil,
            success: {(let channel: RSSChannel!) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.convertItemPropertiesToPlainText(channel.items as! [RSSItem])
                    let editedItems: [RSSItem] =  channel.items as! [RSSItem]
                    
                    for item in editedItems {
                        item.title = "\(channel.title): \(item.title)"
                    }
                    
                    items += editedItems
                    
                    self.urlPos++
                    
                    if self.urlPos < count {
                        self.parseRSSFeeds(urls, items: items, completionHandler: completionHandler)
                    } else {
                        items = items.sort({
                            $1.pubDate.isLessThanDate($0.pubDate)
                        })
                        completionHandler(items, nil)
                    }
                })
                
            }, failure: {(let error: NSError!) -> Void in
                completionHandler(nil, error)
        })
        
    }
    
    func convertItemPropertiesToPlainText(rssItems:[RSSItem]) {
        for item in rssItems {
            let charSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()
            
            if let title = item.title as NSString! {
                item.title = title.stringByConvertingHTMLToPlainText().stringByTrimmingCharactersInSet(charSet)
            }
        }
    }
}

extension NSDate {
    func isGreaterThanDate(dateToCompare : NSDate) -> Bool {
        return self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
    }
    
    func isLessThanDate(dateToCompare : NSDate) -> Bool {
        return self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
    }
}
