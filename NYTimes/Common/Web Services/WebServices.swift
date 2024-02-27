// calling api
// checks internet availability

import Foundation
import SystemConfiguration


public class WebServices {
    
    // creates request from fetch data from server.
    func load<T: Codable>(_ type: T.Type, request: URLRequest?, completion: @escaping (Result<T?, APIError>)-> Void) {
        
        guard let request = request else{
            completion(Result.failure(APIError.failedRequest("HTTP request is failed")))
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(Result.failure(APIError.failedRequest(error?.localizedDescription)))
                
            } else {
                guard let serverData = data,
                      error == nil else {
                    completion(Result.failure(APIError.failedRequest(error?.localizedDescription)))
                    return
                }
                
                do{
                    let decoder = JSONDecoder();
                    let object = try decoder.decode(T.self, from: serverData)
                    
                    completion(Result.success(object))
                } catch let parsingError {
                    completion(Result.failure(APIError.failedRequest(parsingError.localizedDescription)))
                }
            }
        })
        dataTask.resume()
    }
}
