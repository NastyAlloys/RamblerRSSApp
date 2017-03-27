//
//  FeedListWireframe.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 2/8/16.
//  Copyright © 2016 Andrey Egorov. All rights reserved.
//

import Foundation
import UIKit

let FeedListViewControllerIdentifier = "FeedListViewController"

class FeedListWireframe : NSObject {
    var feedListPresenter : FeedListPresenter?
    var rootWireframe : RootWireframe?
    var feedListViewController : FeedListViewController?
    
    func presentListInterfaceFromWindow(window: UIWindow) {
        guard let viewController = listViewControllerFromStoryboard(),
            feedListPresenter = feedListPresenter else { return }
        viewController.feedListPresenter = feedListPresenter
        feedListViewController = viewController
        feedListPresenter.userInterface = viewController
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func listViewControllerFromStoryboard() -> FeedListViewController? {
        let storyboard = mainStoryboard()
        return storyboard.instantiateViewControllerWithIdentifier(FeedListViewControllerIdentifier) as? FeedListViewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    }
    
}
