//
//  FeedListInteractorInput.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 08/02/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

import Foundation
import MediaRSSParser

protocol FeedListInteractorInput {
    func fetchFeeds()
}

protocol FeedListInteractorOutput: class {
    func presentFetchedFeeds(rssItems: [RSSItem])
}
