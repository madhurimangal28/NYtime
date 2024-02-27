import Foundation

// custom error
enum APIError: Error{
    case failedRequest(String?)
}

// hTTPS methods type
enum HttpsMethod {
    case Post
    case Get
    
    // I have added only method becasue i dont need others
    var localization: String {
        switch self {
        case .Post: return "POST"
        case .Get: return "GET"
            
        }
    }
}

// base url + key
enum HttpURL {
    case mostviewed
    
    var localised: String {
        switch self {
        case .mostviewed: return String(format: URLs.mostviewedAPI, Constants.api_key)
            
        }
    }
}

enum PhotoRecordState:String {
    case new
    case downloaded
    case failed
}
