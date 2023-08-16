//  
//  ApiJSONDecoder.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation

class ApiJSONDecoder: JSONDecoder {
    
    static let shared = ApiJSONDecoder()
    
    override init() {
        super.init()
        self.keyDecodingStrategy = .convertFromSnakeCase
    }
    
}
