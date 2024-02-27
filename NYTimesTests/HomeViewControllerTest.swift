//
//  HomeViewControllerTest.swift
//  NYTimesTests
//
//  Created by Madhuri Agrawal on 26/02/24.
//

import XCTest
@testable
import NYTimes

class HomeViewControllerTests: XCTestCase {
    let presenter = MockHomeViewController()
    
    func makeUI() -> HomeViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let screen = storyboard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController {
            screen.loadViewIfNeeded()
            return screen
        }
        return nil
    }
    
    func testViewDidLoadCallsPresenter() {
        presenter.viewDidLoad()
        XCTAssertTrue(presenter.onViewLoadedCalled)
    }
    
    func testToastInHomeVC() {
        let screen = makeUI()
        screen?.updateView("err")
        presenter.showToast(message: "demo message")
        
    }
    
}
