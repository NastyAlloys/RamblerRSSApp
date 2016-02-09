//
//  FeedListPresenter.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 08/02/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

import Foundation
import MediaRSSParser

class FeedListPresenter: NSObject, FeedListInteractorOutput, FeedListModuleInterface {

    var feedListInteractor: FeedListInteractorInput?
    var feedListWireframe: FeedListWireframe?
    weak var userInterface: FeedListViewController?
    
    func updateView() {
        feedListInteractor?.fetchFeeds()
    }
    
    func presentFetchedFeeds(items: [RSSItem]) {
        let data = FeedListDisplayData(source: "", items: items)
        self.userInterface?.showUpcomingDisplayData(data)
    }
}
