//
//  ResponseManager.swift
//
//  Created by Seyed Mojtaba Hosseini Zeidabadi.
//  Copyright © 2020 Chenzook. All rights reserved.
//
//  Linkedin: https://linkedin.com/in/MojtabaHosseini
//  GitHub: https://github.com/MojtabaHs
//  Web: https://chenzook.com
//

import Foundation

open class ResponseManager: HTTPResponseHandler {
    
    public init(jsonParser: JSONParser, responseAdapters: [ResponseAdapter] = []) {
        self.jsonParser = jsonParser
        self.responseAdapters = responseAdapters
    }
    
    open var jsonParser: JSONParser
    open var responseAdapters: [ResponseAdapter]
}

extension ResponseManager {
    
    public static let `default`: ResponseManager = ResponseManager(jsonParser: JSONParsingManager.default)
}
