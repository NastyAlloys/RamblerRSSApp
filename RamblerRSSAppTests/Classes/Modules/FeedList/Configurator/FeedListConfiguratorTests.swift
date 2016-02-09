//
//  FeedListConfiguratorTests.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 08/02/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

import XCTest

class FeedListModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = FeedListViewControllerMock()
        let configurator = FeedListModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewController)

        //then
        XCTAssertNotNil(viewController.output, "FeedListViewController is nil after configuration")
        XCTAssertTrue(viewController.output is FeedListPresenter, "output is not FeedListPresenter")

        let presenter: FeedListPresenter = viewController.output as! FeedListPresenter
        XCTAssertNotNil(presenter.view, "view in FeedListPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in FeedListPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is FeedListRouter, "router is not FeedListRouter")

        let interactor: FeedListInteractor = presenter.interactor as! FeedListInteractor
        XCTAssertNotNil(interactor.output, "output in FeedListInteractor is nil after configuration")
    }

    class FeedListViewControllerMock: FeedListViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
