//
//  NYTimes.swift
//  NYTimesTests
//
//  Created by Madhuri Agrawal on 27/02/24.
//

import Foundation

class NYTimes {
    func getFileData(_ fileName: String) -> Data? {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") else {
            fatalError("UnitTestData.json not found")
        }
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to String")
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to Data")
        }
        return jsonData
    }
}

enum TestType {
    case fail
    case success
}
