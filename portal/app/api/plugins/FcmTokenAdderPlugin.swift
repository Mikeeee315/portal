//  
//  FcmTokenAdderPlugin.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation
import Moya

class FcmTokenAdderPlugin: PluginType {

    private var keychain: KeychainHelperType
    
    init(keychain: KeychainHelperType) {
        self.keychain = keychain
    }

	func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
		var modifiedRequest = request
		if let fcmToken = keychain.fcmToken { modifiedRequest.addValue(fcmToken, forHTTPHeaderField: "x-device-fcm-token") }
		return modifiedRequest
	}

}
