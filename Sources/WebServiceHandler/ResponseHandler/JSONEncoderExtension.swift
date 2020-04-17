//
//  JSONEncoderExtension.swift
//
//  Created by Seyed Mojtaba Hosseini Zeidabadi.
//  Copyright © 2020 Chenzook. All rights reserved.
//
//  Linkedin: https://linkedin.com/in/MojtabaHosseini
//  GitHub: https://github.com/MojtabaHs
//  Web: https://chenzook.com
//

import Foundation

public extension JSONEncoder {
    
    func urlQueryItems<T: Encodable>(encodable: T) throws -> [URLQueryItem]? {
        let encoded = try encode(encodable)
        let jsonObject = try JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        return jsonObject?.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
    }
}
