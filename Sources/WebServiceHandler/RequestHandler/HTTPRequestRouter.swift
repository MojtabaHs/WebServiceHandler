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

public protocol HTTPRequestRouter: URLRequestable {
    associatedtype URLParameters: Encodable
    associatedtype BodyParameters: Encodable
    associatedtype Result: Decodable & DataType
    
    var baseURL: URL { get }
    var path: String { get }

    var urlParametersEncoder: JSONEncoder { get }
    var urlParameters: URLParameters? { get }

    var bodyParameters: BodyParameters? { get }
    var bodyParametersEncoder: JSONEncoder { get }

    var method: String? { get }
}

public extension HTTPRequestRouter {

    func urlRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method;
        if let bodyParameters = bodyParameters {
            urlRequest.httpBody = try bodyParametersEncoder.encode(bodyParameters)
            if #available(iOS 13.0, *) {
                precondition(urlRequest.httpMethod != "GET", "It is not allowed to add a body in GET request since iOS 13")
                precondition(urlRequest.httpMethod != nil, "nil method considered GET and it is not allowed to add a body in GET request since iOS 13")
            }
        }

        guard let urlParameters = urlParameters else { return urlRequest }
        // Append URL parameters
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            assertionFailure("Invalid URL")
            return urlRequest
        }
        urlComponents.queryItems = try urlParametersEncoder.urlQueryItems(encodable: urlParameters)

        var adaptedURLRequest = URLRequest(url: urlComponents.url ?? url)
        adaptedURLRequest.httpBody = urlRequest.httpBody
        adaptedURLRequest.httpMethod = urlRequest.httpMethod
        return adaptedURLRequest
    }
}
