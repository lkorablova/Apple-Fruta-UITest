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

    func testIngredientsCard() throws {
        
        let app = XCUIApplication()
        app.launch()

        app.tables/*@START_MENU_TOKEN@*/.buttons["Crazy Colada, Ingredients: Pineapple, Almond Milk, and Coconut., 320 Calories"]/*[[".cells[\"Crazy Colada, Ingredients: Pineapple, Almond Milk, and Coconut., 320 Calories\"].buttons[\"Crazy Colada, Ingredients: Pineapple, Almond Milk, and Coconut., 320 Calories\"]",".buttons[\"Crazy Colada, Ingredients: Pineapple, Almond Milk, and Coconut., 320 Calories\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        XCTAssert(elementsQuery.staticTexts["Enjoy the tropical flavors of coconut and pineapple!, 320 Calories"].isHittable)

        elementsQuery.staticTexts["Enjoy the tropical flavors of coconut and pineapple!, 320 Calories"].swipeUp()
        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["ALMOND MILK"]/*[[".buttons[\"Almond Milk Ingredient\"].staticTexts[\"ALMOND MILK\"]",".staticTexts[\"ALMOND MILK\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        app.buttons["card_info_button"].tap()
        let viewExists = app.staticTexts["nutrition_facts"].waitForExistence(timeout: 10)
        XCTAssert(viewExists)
    }

    func testIngredientsQuantity() throws {

        let app = XCUIApplication()
        app.launch()

        app.tabBars["Tab Bar"].buttons["Recipes"].tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["Berry Blue, Ingredients: Orange, Blueberry, and Avocado., 520 Calories"]/*[[".cells[\"Berry Blue, Ingredients: Orange, Blueberry, and Avocado., 520 Calories\"].buttons[\"Berry Blue, Ingredients: Orange, Blueberry, and Avocado., 520 Calories\"]",".buttons[\"Berry Blue, Ingredients: Orange, Blueberry, and Avocado., 520 Calories\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let increaseCountButton = app.scrollViews.otherElements.buttons["Increase Count"]
        XCTAssert(app.staticTexts["1 Smoothie"].exists)
        XCTAssert(app.scrollViews.otherElements.switches.firstMatch.label == "Orange, 1.5 cups")

        increaseCountButton.tap()
        increaseCountButton.tap()
        increaseCountButton.tap()
        increaseCountButton.tap()

        XCTAssert(app.staticTexts["5 Smoothies"].exists)
        XCTAssert(app.scrollViews.otherElements.switches.firstMatch.label == "Orange, 7.5 cups")

    }

    func testBuySmoothie() throws {
        let app = XCUIApplication()
        app.launch()

        app.tables.buttons["Crazy Colada, Ingredients: Pineapple, Almond Milk, and Coconut., 320 Calories"].tap()

        XCTAssert(app.buttons["Buy with Apple Pay"].isHittable)

        app.buttons["Buy with Apple Pay"].tap()

        let thankYouText = app.staticTexts["THANK YOU FOR YOUR ORDER!"].waitForExistence(timeout: 10)

        XCTAssert(thankYouText)
        XCTAssert(app.staticTexts["We will notify you when your order is ready."].exists)

        let smoothieReadyText = app.staticTexts["YOUR SMOOTHIE IS READY!"].waitForExistence(timeout: 10)

        XCTAssert(smoothieReadyText)
    }

}
