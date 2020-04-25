//
//  HTTPRequestRouter.swift
//
//  Created by Seyed Mojtaba Hosseini Zeidabadi.
//  Copyright © 2020 Chenzook. All rights reserved.
//
//  Linkedin: https://linkedin.com/in/MojtabaHosseini
//  GitHub: https://github.com/MojtabaHs
//  Web: https://chenzook.com
//

import Foundation

public protocol URLRequestable {
    func urlRequest() throws -> URLRequest
}

public protocol HTTPRequestRouter: URLRequestable {
    associatedtype URLParameters: Encodable
    associatedtype Result: Decodable & DataType
    
    var path: String { get }
    var urlParametersEncoder: JSONEncoder { get }
    var urlParameters: URLParameters? { get }
    var baseURL: URL { get }
}

public extension HTTPRequestRouter {
    func urlRequest() throws -> URLRequest {
                
        let url = baseURL.appendingPathComponent(path)
        guard let urlParameters = urlParameters else { return URLRequest(url: url) }
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            assertionFailure("Invalid URL")
            return URLRequest(url: url)
        }
        urlComponents.queryItems = try urlParametersEncoder.urlQueryItems(encodable: urlParameters)
        return URLRequest(url: urlComponents.url ?? url)
    }
}
