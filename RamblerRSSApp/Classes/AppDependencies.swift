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
        
//        let addWireframe = AddWireframe()
//        let addInteractor = AddInteractor()
//        let addPresenter = AddPresenter()
//        let addDataManager = AddDataManager()
        
        feedListInteractor.output = feedListPresenter
        
        feedListPresenter.feedListInteractor = feedListInteractor
        feedListPresenter.feedListWireframe = feedListWireframe
        
//        listWireframe.addWireframe = addWireframe
        feedListWireframe.feedListPresenter = feedListPresenter
        feedListWireframe.rootWireframe = rootWireframe
        
//        feedListDataManager.coreDataStore = coreDataStore
        
//        addInteractor.addDataManager = addDataManager
//        
//        addWireframe.addPresenter = addPresenter
        
//        addPresenter.addWireframe = addWireframe
//        addPresenter.addModuleDelegate = listPresenter
//        addPresenter.addInteractor = addInteractor
//        
//        addDataManager.dataStore = coreDataStore
    }

}
