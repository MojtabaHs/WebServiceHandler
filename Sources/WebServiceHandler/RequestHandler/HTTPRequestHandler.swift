//
//  HTTPRequestHandler.swift
//
//  Created by Seyed Mojtaba Hosseini Zeidabadi.
//  Copyright © 2020 Chenzook. All rights reserved.
//
//  Linkedin: https://linkedin.com/in/MojtabaHosseini
//  GitHub: https://github.com/MojtabaHs
//  Web: https://chenzook.com
//

import Foundation

public protocol URLRequestAdapter {
    func adaptedURLRequest(from urlRequest: URLRequest) -> URLRequest
}

public protocol HTTPRequestHandler {
    var urlSession: URLSession { get }
    var urlRequestAdapters: [URLRequestAdapter] { get }
    func resumeDataTask(urlRequestable: URLRequestable, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) throws -> URLSessionDataTask
}

public extension HTTPRequestHandler {
    var urlRequestAdapters: [URLRequestAdapter] { return [] }
    
    func resumeDataTask(urlRequestable: URLRequestable, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) throws -> URLSessionDataTask {
        
        let originalURLRequest = try urlRequestable.urlRequest()
        
        var adaptedURLRequest = originalURLRequest
        for adapter in urlRequestAdapters {
            adaptedURLRequest = adapter.adaptedURLRequest(from: adaptedURLRequest)
        }
        
        let request = adaptedURLRequest
        
        let currentQueue = OperationQueue.current
        
        let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
            currentQueue?.addOperation {
                completionHandler(data, response, error)
            }
        })
        task.resume()
        
        return task
    }
}
