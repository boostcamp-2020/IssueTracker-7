//
//  HTTPManager.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import UIKit

enum HttpMethod: String {
    case post,
         get
}

class HTTPManager {
    
    static func openSite(url: String) {
        guard let url = URL(string: url) else { return }
        
        UIApplication.shared.open(url)
    }
    
    
    
    static func request(method: HttpMethod, url: String, body: [String: String]? = nil, header: [String: String]? = nil, completionHandler: ((Data, Error?) -> Void)? = nil) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let body = body?.encode().data(using:String.Encoding.utf8)
        request.httpBody = body
        
       
        header?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // TODO: 응답처리 및 이 부분 모듈화

            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                
                print("Error: HTTP request failed")
                return
            }
            
            guard let completionHandler = completionHandler else { return }
            completionHandler(data, error)
        }
        task.resume()
    }
}


extension Dictionary {
    func encode() -> String {
        return self.map { key, value in
            "\(key)=\(value)"
        }.joined(separator: "&")
    }
}

