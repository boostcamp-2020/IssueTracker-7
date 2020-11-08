//
//  MockRouter.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/09.
//

import Foundation

final class MockRouter: Routable {
    
    func openSite(from route: EndPointable) { }
    
    func request<T: Decodable>(route: EndPointable, completionHandler: ((Result<T, APIError>) -> Void)? = nil) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            
            guard let completionHandler = completionHandler else { return }
            
            guard let data = JsonFactory.loadJson(endPoint: route) else {
                completionHandler(.failure(.data))
                return
            }
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(model))
            } catch {
                print(error)
                completionHandler(.failure(.decodingJSON))
            }
        }
    }
}
