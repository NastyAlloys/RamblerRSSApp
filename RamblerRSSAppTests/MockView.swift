//
//  MockView.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 2/9/16.
//  Copyright © 2016 Andrey Egorov. All rights reserved.
//

import XCTest

class MockView: FeedListViewController {
    
    var presenter: FeedListPresenter! = nil
    var updateWaterLevelCalled = false
    var levelString: String! = nil
    func updateWaterLevel(level: String) {
        updateWaterLevelCalled = true
        levelString = level
    }
    var updateTemperatureStringCalled = false
    var temperatureString: String! = nil
    func updateTemperature(temperature: String) {
        updateTemperatureStringCalled = true
        temperatureString = temperature
    }
    
    
}
