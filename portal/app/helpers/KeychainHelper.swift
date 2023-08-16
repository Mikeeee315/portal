//  
//  KeychainHelper.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import KeychainSwift

protocol KeychainHelperType {
    var accessToken: String? { get set }
	var refreshToken: String? { get set }
	var fcmToken: String? { get set }
    func clear()
}

class KeychainHelper: KeychainHelperType {
    
    static let shared = KeychainHelper()
    
    private let internalKeychain: KeychainSwift = KeychainSwift(keyPrefix: Config.shared.namespace)
    
    enum Keys: String {
        case accessToken
		case refreshToken
		case fcmToken
    }

//	var <ITEM>: String? {
//        set {
//            guard let value = newValue else {
//                internalKeychain.delete(Keys.<ITEM>.rawValue)
//                return
//            }
//            internalKeychain.set(value, forKey: Keys.<ITEM>.rawValue)
//        }
//        get {
//            return internalKeychain.get(Keys.<ITEM>.rawValue)
//        }
//    }
    
    var accessToken: String? {
        set {
            guard let value = newValue else {
                internalKeychain.delete(Keys.accessToken.rawValue)
                return
            }
            internalKeychain.set(value, forKey: Keys.accessToken.rawValue)
        }
        get {
            return internalKeychain.get(Keys.accessToken.rawValue)
        }
    }

    var refreshToken: String? {
        set {
            guard let value = newValue else {
                internalKeychain.delete(Keys.refreshToken.rawValue)
                return
            }
            internalKeychain.set(value, forKey: Keys.refreshToken.rawValue)
        }
        get {
            return internalKeychain.get(Keys.refreshToken.rawValue)
        }
    }

    var fcmToken: String? {
        set {
            guard let value = newValue else {
                internalKeychain.delete(Keys.fcmToken.rawValue)
                return
            }
            internalKeychain.set(value, forKey: Keys.fcmToken.rawValue)
        }
        get {
            return internalKeychain.get(Keys.fcmToken.rawValue)
        }
    }
    
    func clear() {
        internalKeychain.clear()
    }
    
}
