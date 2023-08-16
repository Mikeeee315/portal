//  
//  AuthenticationPlugin.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation
import Moya

class AuthenticationPlugin: PluginType {
    
    private var keychain: KeychainHelperType
    
    init(keychain: KeychainHelperType) {
        self.keychain = keychain
    }
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        let api = target as! ApiService
        var modifiedRequest = request
        if api.requiresAuthentication {
            let accessToken = keychain.accessToken.expect("Expected access token for path: \(target.path)")
            modifiedRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        return modifiedRequest
    }
    
}
