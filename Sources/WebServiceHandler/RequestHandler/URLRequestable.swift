//
//  URLRequestable.swift
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

extension URLRequest: URLRequestable {
    public func urlRequest() throws -> URLRequest { self }
}
