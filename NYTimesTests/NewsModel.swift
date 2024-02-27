//
//  NewsModel.swift
//  MVVMDemoTests
//
//  Created by Madhuri Agrawal on 26/02/24.
//

import XCTest
@testable
import NYTimes


class NewsDetailInfoTests: XCTestCase {
    
    func testDecoding() throws {
        let loader = NYTimes()
        guard let jsonData = loader.getFileData("news") else {
            XCTAssert(false)
            return
        }
        let decoder = JSONDecoder()
        let newsModel = try decoder.decode(NewsModel.self, from: jsonData)
        guard let newsDetailInfo = newsModel.results?.first else {
            XCTAssert(false)
            return
        }
        
        XCTAssertEqual(newsModel.status, "ok")
        XCTAssertEqual(newsModel.copyright, "Demo")
        XCTAssertEqual(newsModel.numResults, 1)
        
        XCTAssertEqual(newsDetailInfo.uri, "https://www.example.com/news/123")
        XCTAssertEqual(newsDetailInfo.url, "https://www.example.com/article/123")
        XCTAssertEqual(newsDetailInfo.id, 123)
        XCTAssertEqual(newsDetailInfo.assetID, 456)
        XCTAssertEqual(newsDetailInfo.source, "Example News")
        XCTAssertEqual(newsDetailInfo.publishedDate, "2022-03-01")
        XCTAssertEqual(newsDetailInfo.updated, "2022-03-02T10:30:00Z")
        XCTAssertEqual(newsDetailInfo.section, "Politics")
        XCTAssertEqual(newsDetailInfo.subsection, "Elections")
        XCTAssertEqual(newsDetailInfo.nytdsection, "politics")
        XCTAssertEqual(newsDetailInfo.adxKeywords, "elections, candidates")
        XCTAssertNil(newsDetailInfo.column)
        XCTAssertEqual(newsDetailInfo.byline, "John Doe")
        XCTAssertEqual(newsDetailInfo.type, "Article")
        XCTAssertEqual(newsDetailInfo.title, "Example News Article")
        XCTAssertEqual(newsDetailInfo.abstract, "This is an example news article.")
        XCTAssertEqual(newsDetailInfo.desFacet, ["politics", "elections"])
        XCTAssertEqual(newsDetailInfo.orgFacet, ["Example News"])
        XCTAssertEqual(newsDetailInfo.perFacet, ["John Doe"])
        XCTAssertEqual(newsDetailInfo.geoFacet, ["United States"])
        XCTAssertEqual(newsDetailInfo.media?.count, 1)
        XCTAssertEqual(newsDetailInfo.etaID, 789)
        
        let media = newsDetailInfo.media?.first
        XCTAssertEqual(media?.type, .image)
        XCTAssertEqual(media?.subtype, "photo")
        XCTAssertEqual(media?.caption, "Example Image")
        XCTAssertEqual(media?.mediaMetadata?.count, 1)
        
        let mediaMetadata = media?.mediaMetadata?.first
        XCTAssertEqual(mediaMetadata?.url, "https://www.example.com/image.jpg")
        XCTAssertEqual(mediaMetadata?.format, .standardThumbnail)
    }
}

class MockHomeViewController: UIViewController {
    private(set) var onViewLoadedCalled = false
    override func viewDidLoad() {
        onViewLoadedCalled = true
    }
}
