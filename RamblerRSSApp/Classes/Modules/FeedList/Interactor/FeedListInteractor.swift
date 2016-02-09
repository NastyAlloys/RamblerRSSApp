//
//  FeedListInteractor.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 08/02/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

import Foundation

class FeedListInteractor: NSObject, FeedListInteractorInput {

    weak var output: FeedListInteractorOutput!
    let dataManager: FeedListDataManager
    
    let urls = [
        "http://www.gazeta.ru/export/rss/lenta.xml",
        "http://lenta.ru/rss"
    ]
    
    init(dataManager: FeedListDataManager) {
        self.dataManager = dataManager
    }
    
    func fetchFeeds() {
        dataManager.fetchFeeds(urls, completionHandler: { response, error in
            if (error != nil) {
                print(error)
                return
            }
            
            self.output.presentFetchedFeeds(response!)
        })
    }
    
}
