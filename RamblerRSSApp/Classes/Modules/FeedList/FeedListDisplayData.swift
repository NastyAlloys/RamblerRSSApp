//
//  FeedListDisplaySection.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 2/8/16.
//  Copyright © 2016 Andrey Egorov. All rights reserved.
//

import Foundation
import MediaRSSParser

struct FeedListDisplayData {
    var source: String = ""
    var items: [RSSItem] = []
    
    init (source: String, items: [RSSItem]?) {
        self.source = source
        
        if let items = items {
            self.items = items
        }
    }
}