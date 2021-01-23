//
//  WebServiceManger.swift
//
//  Created by Seyed Mojtaba Hosseini Zeidabadi.
//  Copyright © 2020 Chenzook. All rights reserved.
//
//  Linkedin: https://linkedin.com/in/MojtabaHosseini
//  GitHub: https://github.com/MojtabaHs
//  Web: https://chenzook.com
//

import Foundation

open class WebServiceManager: HTTPWebServiceHandler {
    
    public init(requestHandler: HTTPRequestHandler, responseHandler: HTTPResponseHandler) {
        self.requestHandler = requestHandler
        self.responseHandler = responseHandler
    }
    
    open var requestHandler: HTTPRequestHandler
    open var responseHandler: HTTPResponseHandler
    
    open func resumeDataTask<T: DataType, U: DataType>(
        urlRequestable: URLRequestable,
        success: @escaping (T?) -> Void = { _ in },
        failure: @escaping (U?, Error?) -> Void = { _, _ in }) throws -> URLSessionDataTask {
        
        try requestHandler.resumeDataTask(
            urlRequestable: urlRequestable,
            completionHandler: { (data, response, error) in
                self.responseHandler.handleResponse(request: try! urlRequestable.urlRequest(), data: data, response: response, error: error, success: success, failure: failure)
        })
    }
}

public extension WebServiceManager {
    
    static let `default` = WebServiceManager(
        requestHandler: RequestManager.default,
        responseHandler: ResponseManager.default
    )
}
