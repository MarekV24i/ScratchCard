//
//  VyoralUITests.swift
//  VyoralUITests
//
//  Created by Marek on 29.01.2024.
//

import XCTest

final class VyoralUITests: XCTestCase {
    
    private let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    func testSuccesUseCase() throws {
        XCUIApplication().buttons["scratch_button"].tap()
        XCUIApplication().buttons["scratch_screen_button"].tap()
        let _ = app.buttons["Scratching finished"].waitForExistence(timeout: 5)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCUIApplication().buttons["activate_button"].tap()
        XCUIApplication().buttons["activate_screen_button"].tap()
        XCTAssert(app.buttons["Activated"].waitForExistence(timeout: 5))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
