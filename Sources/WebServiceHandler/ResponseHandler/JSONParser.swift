//
//  JSONParser.swift
//
//  Created by Seyed Mojtaba Hosseini Zeidabadi.
//  Copyright © 2020 Chenzook. All rights reserved.
//
//  Linkedin: https://linkedin.com/in/MojtabaHosseini
//  GitHub: https://github.com/MojtabaHs
//  Web: https://chenzook.com
//

import Foundation

public protocol JSONParser: Parser {
    var jsonDecoder: JSONDecoder { get }
    func parseData<T: Decodable>(_ data: Data, to: T.Type) throws -> T
}

public extension JSONParser {

    func parseData<T: Decodable>(_ data: Data, to: T.Type) throws -> T { try jsonDecoder.decode(T.self, from: data) }
}
