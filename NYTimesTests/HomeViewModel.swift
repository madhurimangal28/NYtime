//
//  HomeViewModel.swift
//  NYTimesTests
//
//  Created by Madhuri Agrawal on 26/02/24.
//

import XCTest
@testable
import NYTimes

class HomeViewModelTests: XCTestCase {
    var viewModel: MockHomeViewModel!
    let expectation = XCTestExpectation(description: "Fetch most popular news")
   
    override func setUp() {
        super.setUp()
        viewModel = MockHomeViewModel()
        viewModel.delegate = self
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchMostPopularNewsSuccess() {
       
        viewModel.testType = .success
        viewModel.fetchMostPopularNews()
        wait(for: [expectation], timeout: 10)
    }
    func testFetchMostPopularNewsFail() {
        viewModel.testType = .fail
        viewModel.fetchMostPopularNews()
        wait(for: [expectation], timeout: 10)
    }
    
    func testStartOperations() {
        let photoRecord = ProfilePhoto(id: 1, url: "https://example.com/image.jpg")
        viewModel.startOperations(photoRecord: photoRecord)
        XCTAssertTrue(viewModel.pendingOperations.downloadsInProgress[photoRecord.id] != nil)
    }
    
}

extension HomeViewModelTests: HomePageDelegate {
    func updateView(_ error: String?) {
        if viewModel.testType == .fail {
            XCTAssertFalse(error?.isEmpty ?? true)
        } else {
            XCTAssertTrue(viewModel.newsItems != nil)
            XCTAssertTrue(viewModel.photos.count > 0)
        }
        expectation.fulfill()
    }
}

class MockHomeViewModel: HomeViewModel {
    var testType: TestType = .fail
    
    override func fetchMostPopularNews() {
        switch testType {
        case .fail:
            self.delegate?.updateView("failed")
        case .success:
            self.newsItems = [NewsDetailInfo.init(uri: "", url: "", id: 1, assetID: 1, source: "", publishedDate: "", updated: "", section: "", subsection: "", nytdsection: "", adxKeywords: "", column: "", byline: "", type: "", title: "", abstract: "", desFacet: [""], orgFacet: nil, perFacet: nil, geoFacet: nil, media: nil, etaID: 0)]
            self.photos = [ProfilePhoto.init(id: 1, url: "")]
            self.delegate?.updateView(nil)
        }
    }
}
 
