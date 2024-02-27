//
//  URLRequest.swift
//  Assignment
//
//  Created by Madhuri Agrawal on 31/03/19.
//

import Foundation

struct HeaderRequest {
    
    func getRequest(httpMethod: HttpsMethod, url: String) -> URLRequest? {
        guard let validURL = URL(string: url) else{
            return nil
        }
        var request = URLRequest(url: validURL)
        request.httpMethod = httpMethod.localization
        request.timeoutInterval = 60
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        return request
    }
}
