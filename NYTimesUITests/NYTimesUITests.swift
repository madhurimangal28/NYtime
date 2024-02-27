//
//  NYTimesUITests.swift
//  NYTimesUITests
//
//  Created by Madhuri Agrawal on 23/02/24.
//

import XCTest

class NYTimesUITests: XCTestCase {

    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testHomeScreenUI() {
        XCTAssert(app.staticTexts["Home"].exists)
        let table = app.tables["article_list"]
        
        let cell0 = table.cells["cell0"]
        _ = cell0.waitForExistence(timeout: 5)
        let cell1 = table.cells["cell1"]
        let cell2 = table.cells["cell2"]
        let cellLabel = cell0.staticTexts["label_name"]
        let cellImage = cell0.images["thumb_image"]
        XCTAssert(cell0.exists)
        XCTAssert(cell1.exists)
        XCTAssert(cell2.exists)
        XCTAssert(cellLabel.exists)
        XCTAssert(cellImage.exists)
    }
    
    func testHitCellByElement() {
        let tableHome = app.tables["article_list"]
        
        let cell0 = tableHome.cells["cell0"]
        _ = cell0.waitForExistence(timeout: 5)
        cell0.tap()
        XCTAssert(app.staticTexts["Article Details"].exists)
        let tableDetails = app.tables["article_detail"]
       
        let cellDetail0 = tableDetails.cells["detailCell0"]
        _ = cellDetail0.waitForExistence(timeout: 5)
        XCTAssert(cellDetail0.exists)
        XCTAssert(tableDetails.cells.count > 0)
        let title = cellDetail0.staticTexts["titleLabel"]
        let postDetailLabel = cellDetail0.staticTexts["postDescriptionLabel"]
        let poster = cellDetail0.images["posterImage"]
        XCTAssert(title.exists)
        XCTAssert(postDetailLabel.exists)
        XCTAssert(poster.exists)
    }

    func testBackButton() {
        let tableHome = app.tables["article_list"]
        let cell0 = tableHome.cells["cell0"]
        _ = cell0.waitForExistence(timeout: 5)
        cell0.tap()
        XCTAssert(app.staticTexts["Article Details"].exists)
        let tableDetails = app.tables["article_detail"]
        let cellDetail0 = tableDetails.cells["detailCell0"]
        _ = cellDetail0.waitForExistence(timeout: 5)
        XCTAssert(cellDetail0.exists)
        let backButton = app.navigationBars.buttons["Home"]
        XCTAssert(backButton.exists)
        XCTAssert(backButton.isHittable)
        backButton.tap()
        XCTAssert(app.staticTexts["Home"].exists)
    }
    
}
