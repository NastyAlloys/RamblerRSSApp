//
//  PresenterTests.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 2/9/16.
//  Copyright © 2016 Andrey Egorov. All rights reserved.
//

import XCTest
import MediaRSSParser

class PresenterTests: XCTestCase {
    
    let presenter = FeedListPresenter()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        presenter.userInterface = nil
        presenter.feedListInteractor = nil
    }
    
    func testPresenterUpdatesView() {
        presenter.updateView()
//        XCTAssertTrue(mockView.updateWaterLevelCalled)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}