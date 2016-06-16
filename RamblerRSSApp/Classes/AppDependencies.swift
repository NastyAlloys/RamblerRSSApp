//
//  AppDependencies.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 2/8/16.
//  Copyright © 2016 Andrey Egorov. All rights reserved.
//

import UIKit
import Foundation

class AppDependencies {
    var feedListWireframe = FeedListWireframe()
    
    init() {
        configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(window: UIWindow) {
        feedListWireframe.presentListInterfaceFromWindow(window)
    }
    
    func configureDependencies() {
        let rootWireframe = RootWireframe()
        
        let feedListPresenter = FeedListPresenter()
        let feedListDataManager = FeedListDataManager()
        let feedListInteractor = FeedListInteractor(dataManager: feedListDataManager)
        
        feedListInteractor.output = feedListPresenter
        
        feedListPresenter.feedListInteractor = feedListInteractor
        feedListPresenter.feedListWireframe = feedListWireframe
        
        feedListWireframe.feedListPresenter = feedListPresenter
        feedListWireframe.rootWireframe = rootWireframe
    }

}
