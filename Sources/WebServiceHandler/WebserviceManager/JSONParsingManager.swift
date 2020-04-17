//
//  JSONParsingManager.swift
//
//  Created by Seyed Mojtaba Hosseini Zeidabadi.
//  Copyright © 2020 Chenzook. All rights reserved.
//
//  Linkedin: https://linkedin.com/in/MojtabaHosseini
//  GitHub: https://github.com/MojtabaHs
//  Web: https://chenzook.com
//

import Foundation

open class JSONParsingManager: JSONParser {
    
    public init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }
    
    open var jsonDecoder: JSONDecoder
    
    open func parseData<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

extension JSONParsingManager {
    
    public static let `default`: JSONParsingManager = {
        let jsonDecoder = JSONDecoder()
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            return formatter
        }()
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return JSONParsingManager(jsonDecoder: jsonDecoder)
    }()
}
