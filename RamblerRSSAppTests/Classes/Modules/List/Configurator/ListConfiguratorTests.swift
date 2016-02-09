//
//  ListConfiguratorTests.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 08/02/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

import XCTest

class ListModuleConfiguratorTests: XCTestCase {

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
        let viewController = ListViewControllerMock()
        let configurator = ListModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewController)

        //then
        XCTAssertNotNil(viewController.output, "ListViewController is nil after configuration")
        XCTAssertTrue(viewController.output is ListPresenter, "output is not ListPresenter")

        let presenter: ListPresenter = viewController.output as! ListPresenter
        XCTAssertNotNil(presenter.view, "view in ListPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in ListPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is ListRouter, "router is not ListRouter")

        let interactor: ListInteractor = presenter.interactor as! ListInteractor
        XCTAssertNotNil(interactor.output, "output in ListInteractor is nil after configuration")
    }

    class ListViewControllerMock: ListViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
