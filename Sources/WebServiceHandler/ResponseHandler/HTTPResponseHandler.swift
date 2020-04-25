//
//  HTTPResponseHandler.swift
//
//  Created by Seyed Mojtaba Hosseini Zeidabadi.
//  Copyright © 2020 Chenzook. All rights reserved.
//
//  Linkedin: https://linkedin.com/in/MojtabaHosseini
//  GitHub: https://github.com/MojtabaHs
//  Web: https://chenzook.com
//

import Foundation

public protocol ResponseAdapter {
    func adaptedResponse(data: Data?, response: URLResponse?, error: Error?) -> (data: Data?, response: URLResponse?, error: Error?)
}

public protocol HTTPResponseHandler {
    var parser: Parser { get }
    var responseAdapters: [ResponseAdapter] { get }
    func handleResponse<T: DataType, U: DataType>(data: Data?, response: URLResponse?, error: Error?, success: @escaping (T?) -> Void, failure: @escaping (U?, Error?) -> Void)
}

public extension HTTPResponseHandler {
    
    var responseAdapters: [ResponseAdapter] { [] }
    
    func handleResponse<T: DataType, U: DataType>(data: Data?, response: URLResponse?, error: Error?, success: @escaping (T?) -> Void, failure: @escaping (U?, Error?) -> Void) {
        
        let originalResponse = (data: data, response: response, error: error)
        
        var adaptedResponse = originalResponse
        for adapter in responseAdapters {
            adaptedResponse = adapter.adaptedResponse(data: data, response: response, error: error)
        }
        
        // MARK: Adapt and check error
        let error = adaptedResponse.error
        guard error == nil else { return failure(nil, error) }

        // MARK: Adapt and check response
        let response = adaptedResponse.response
        guard let httpResponse = response as? HTTPURLResponse else { return failure(nil, error) }
        
        // MARK: Adapt and check data
        let data = adaptedResponse.data
        var isSuccess: Bool { return (100..<400).contains(httpResponse.statusCode) }
        guard let responseData = data else { return isSuccess ? success(nil) : failure(nil, nil) }

        do {
            if isSuccess {
                let result = try parser.parseData(responseData, to: T.self)
                return success(result)
            } else {
                let result = try parser.parseData(responseData, to: U.self)
                return failure(result, error)
            }
        } catch {
            return failure(nil, error)
        }
    }
}
