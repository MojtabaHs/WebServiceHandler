//
//  ProtobufParser.swift
//
//  Created by Seyed Mojtaba Hosseini Zeidabadi.
//  Copyright © 2020 Chenzook. All rights reserved.
//
//  Linkedin: https://linkedin.com/in/MojtabaHosseini
//  GitHub: https://github.com/MojtabaHs
//  Web: https://chenzook.com
//

import Foundation
import SwiftProtobuf

public protocol ProtobufParser: Parser {
    func parseData<T: Message>(_ data: Data, to: T.Type) throws -> T
}

public extension ProtobufParser {

    func parseData<T: Message>(_ data: Data, to: T.Type) throws -> T { try T.init(serializedData: data) }
}
