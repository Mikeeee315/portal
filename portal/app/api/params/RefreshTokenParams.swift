//  
//  RefreshTokenParams.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation

struct RefreshTokenParams: Codable {
    	
    // MARK: - Passport

    let grantType: String = "refresh_token"
    let clientId: Int = Int(Config.shared.clientId).expect("unexpected client id registerd in config.")
    let clientSecret: String = Config.shared.clientSecret
    let scope: String = Config.shared.clientScope
    
    // MARK: - Init

    var refreshToken: String
    
    init(refreshToken: String) {
        self.refreshToken = refreshToken
    }

}
