//  
//  ApiJSONEncoder.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation

class ApiJSONEncoder: JSONEncoder {
    
    static let shared = ApiJSONEncoder()
    
    override init() {
        super.init()
        self.keyEncodingStrategy = .convertToSnakeCase
    }
    
}
