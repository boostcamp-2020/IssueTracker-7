//
//  HTTPManager.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/27.
//

import UIKit


enum APIError: Error {
    case data,
         decodingJSON
    case redirection,  // 300 번
         client,        // 400 번
         server,        // 500 번
         failed
}

final class Router<EndPoint: EndPointable> {
    private var task: URLSessionTask?
    
    func openSite(from route: EndPoint) {
        guard let url = URL(string: "\(route.baseURL)\(route.query)") else { return }
        UIApplication.shared.open(url)
    }
    
    func handleNetworkResponseError(_ response: HTTPURLResponse) -> APIError? {
        switch response.statusCode {
        case 200...299: return nil
        case 300...399: return .redirection
        case 401...500: return .client
        case 501...599: return .server
        default: return .failed
        }
    }
    
    private func configureRequest(from route: EndPoint) -> URLRequest {
        let url = route.query == "" ? route.baseURL : route.baseURL.appendingPathComponent(route.query)
        var request = URLRequest(url: url)
    
        request.httpMethod = route.httpMethod?.rawValue
        request.httpBody = route.bodies?.encode().data(using: String.Encoding.utf8)
        route.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
   
    func request<T: Decodable>(route: EndPoint, completionHandler: ((Result<T,APIError>) -> Void)? = nil) {
        let session = URLSession.shared
        
        let request = configureRequest(from: route)
        task = session.dataTask(with: request) { data, response, error in
            guard let completionHandler = completionHandler else { return }
            
            guard let data = data else {
                completionHandler(.failure(.data))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let responseError = self.handleNetworkResponseError(response)
                
                switch responseError {
                case nil: // 200번
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        completionHandler(.success(model))
                    } catch {
                        print(error)
                        completionHandler(.failure(.decodingJSON))
                    }
                default: // 300~500번
                    if let responseError = responseError {
                        completionHandler(.failure(responseError))
                    }
                }
            }
            
        }
        task?.resume()
    }
}


extension Dictionary {
    func encode() -> String {
        return self.map { key, value in
            "\(key)=\(value)"
        }.joined(separator: "&")
    }
}

