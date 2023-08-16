//  
//  LoginParams.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation

struct LoginParams: Codable {

    // MARK: - Passport

    let grantType: String = "password"
    let clientId: Int = Int(Config.shared.clientId).expect("unexpected client id registerd in config.")
    let clientSecret: String = Config.shared.clientSecret
    let scope: String = Config.shared.clientScope

    // MARK: - Init

    var username: String
    var password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }

}
