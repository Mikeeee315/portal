//  
//  LoginResponse.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation

struct LoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
