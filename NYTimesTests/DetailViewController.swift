//
//  DetailViewController.swift
//  NYTimesTests
//
//  Created by Madhuri Agrawal on 26/02/24.
//

import XCTest
@testable
import NYTimes

final class DetailViewController: XCTestCase {

    let presenter = MockHomeViewController()
    
    func makeUI() -> ArticleDetailViewController? {
       
        let viewModel = ArticleDetailViewModel(nil)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let detailSscreen = storyboard.instantiateViewController(identifier: String(describing: ArticleDetailViewController.self)) { creator in
            let viewController = ArticleDetailViewController(viewModel, coder: creator)
            return viewController
        }
        if let vc = detailSscreen as? ArticleDetailViewController {
            vc.loadViewIfNeeded()
            return vc
        }
        return nil
    }
    
    func testViewDidLoadCallsPresenter() {
        presenter.viewDidLoad()
        XCTAssertTrue(presenter.onViewLoadedCalled)
        let obj = makeUI()
        obj?.updateView("err")
        XCTAssertNotNil(obj)
        
    }

}
