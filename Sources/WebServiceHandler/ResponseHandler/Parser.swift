//
//  Parser.swift
//
//  Created by Seyed Mojtaba Hosseini Zeidabadi.
//  Copyright © 2020 Chenzook. All rights reserved.
//
//  Linkedin: https://linkedin.com/in/MojtabaHosseini
//  GitHub: https://github.com/MojtabaHs
//  Web: https://chenzook.com
//

import Foundation

public protocol DataType: Decodable { }

public protocol Parser {
    func parseData<T: DataType>(_ data: Data, to: T.Type) throws -> T
}
