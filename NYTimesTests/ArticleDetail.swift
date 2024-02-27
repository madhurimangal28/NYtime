//
//  ArticleDetail.swift
//  NYTimesTests
//
//  Created by Madhuri Agrawal on 26/02/24.
//

import XCTest
@testable import NYTimes

class ArticleDetailsTests: XCTestCase {
    
    func testInit_WithValidData_ShouldCreateInstance() {
        // Arrange
        let title = "Test Title"
        let abstract = "Test Abstract"
        let media = "Test Media"
        let id = 1
        let imageData = Data()
        
        // Act
        let articleDetails = ArticleDetails(title: title, abstract: abstract, media: media, id: id, imageData: imageData)
        
        // Assert
        XCTAssertEqual(articleDetails.title, title)
        XCTAssertEqual(articleDetails.abstract, abstract)
        XCTAssertEqual(articleDetails.media, media)
        XCTAssertEqual(articleDetails.id, id)
        XCTAssertEqual(articleDetails.imageData, imageData)
    }
    
    func testInit_WithNilTitle_ShouldCreateInstanceWithEmptyTitle() {
        // Arrange
        let abstract = "Test Abstract"
        let media = "Test Media"
        let id = 1
        let imageData = Data()
        
        // Act
        let articleDetails = ArticleDetails(title: "", abstract: abstract, media: media, id: id, imageData: imageData)
        
        // Assert
        XCTAssertNotNil(articleDetails.title)
        XCTAssertEqual(articleDetails.title, "")
        XCTAssertEqual(articleDetails.abstract, abstract)
        XCTAssertEqual(articleDetails.media, media)
        XCTAssertEqual(articleDetails.id, id)
        XCTAssertEqual(articleDetails.imageData, imageData)
    }
    
    func testInit_WithNilAbstract_ShouldCreateInstanceWithEmptyAbstract() {
        // Arrange
        let title = "Test Title"
        let media = "Test Media"
        let id = 1
        let imageData = Data()
        
        // Act
        let articleDetails = ArticleDetails(title: title, abstract: "", media: media, id: id, imageData: imageData)
        
        // Assert
        XCTAssertEqual(articleDetails.title, title)
        XCTAssertNotNil(articleDetails.abstract)
        XCTAssertEqual(articleDetails.abstract, "")
        XCTAssertEqual(articleDetails.media, media)
        XCTAssertEqual(articleDetails.id, id)
        XCTAssertEqual(articleDetails.imageData, imageData)
    }
    
    // Add more test cases for other properties and scenarios
    
}
