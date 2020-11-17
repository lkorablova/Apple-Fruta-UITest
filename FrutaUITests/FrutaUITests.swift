//
//  FrutaUITests.swift
//  FrutaUITests
//
//  Created by Viktor Nakyden on 17.11.20.
//  Copyright © 2020 Apple. All rights reserved.
//

import XCTest

class FrutaUITests: XCTestCase {

    func testTabBarVisible() throws {
        let app = XCUIApplication()
        app.launch()

        let tabBars = app.tabBars.firstMatch

        XCTAssert(tabBars.buttons.count == 4)
    }


    func testFavourites() throws {

        let app = XCUIApplication()
        app.launch()
        let berryBlueIngredientsOrangeBlueberryAndAvocado520CaloriesButton = app.tables.buttons["Berry Blue, Ingredients: Orange, Blueberry, and Avocado., 520 Calories"]
        berryBlueIngredientsOrangeBlueberryAndAvocado520CaloriesButton.tap()

        let berryBlueNavigationBar = app.navigationBars["Berry Blue"]
        let loveButton = berryBlueNavigationBar.buttons["love"]

        XCTAssert(loveButton.isHittable)
        loveButton.tap()
        app.tabBars["Tab Bar"].buttons["Favorites"].tap()

        berryBlueIngredientsOrangeBlueberryAndAvocado520CaloriesButton.tap()
        loveButton.tap()
        berryBlueNavigationBar.buttons["Favorites"].tap()

        XCTAssert(app.tables.firstMatch.buttons.count == 0)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
