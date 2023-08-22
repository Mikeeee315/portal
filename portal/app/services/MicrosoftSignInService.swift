//
//  MicrosoftSignInService.swift
//  portal
//
//  Created by Michael de Guzman on 8/17/23.
//

import Foundation
import MSAL
import UIKit

protocol MicrosoftSignInServicing: AnyObject {
	
	func start()
	
}

protocol MicrosoftSignInServiceable: AnyObject {
	
	func microsoftSignInInSuccess(withServerAuthCode serverAuthCode: String)
	func microsoftSignInFailed(error: String)
	
}

class MicrosoftSignInService: NSObject, MicrosoftSignInServicing {
	
	weak var serviceable: MicrosoftSignInServiceable?
	weak var viewController: UIViewController?
	
	let kScopes: [String] = ["user.read"]
	
	var accessToken = String()
	var applicationContext : MSALPublicClientApplication?
	var webViewParamaters : MSALWebviewParameters?

	var loggingText: UITextView!
	var signOutButton: UIButton!
	var callGraphButton: UIButton!
	var usernameLabel: UILabel!
	
	var currentAccount: MSALAccount?
	
	var currentDeviceMode: MSALDeviceMode?

	
	init(viewController: UIViewController) {
		self.viewController = viewController
	}
	
	func start() {
		
		acquireTokenInteractively()
//		GIDSignIn.sharedInstance.signOut()
//		presentGoogleSignIn()
		
	}
	
	deinit {
		let className = String(describing: self)
		print("\(className) was deallocated.")
	}
	
}

extension MicrosoftSignInService {
	
//	func presentMicrosoftSignIn() {
//
//		guard let viewController = self.viewController else {return}

		// Create Google Sign In configuration object.
		
//		let config = GIDConfiguration(clientID: Config.shared.googleClientId)
		
		//This is when you have already google server client id(with backend setup)
//		let config = GIDConfiguration(clientID: Config.shared.googleClientId, serverClientID: Config.shared.googleServerClientId)

//		GIDSignIn.sharedInstance.configuration = config
		
		// Start the sign in flow!
//		GIDSignIn.sharedInstance.signIn(withPresenting: viewController){ [unowned self] user, error in
			
//			guard error == nil else { return }
//
//			guard let user = user else { return }
//
			//Test if it is working print userid
//			print("UserID:\(String(describing: user.user.userID))")
//			print("serverAuthCode:\(String(describing: user.serverAuthCode))")
//
//				if let idToken = user.authentication.idToken {
//			if let serverAuthCode = user.serverAuthCode {
//			if let idToken = user.authentication.idToken {
//				serviceable?.googleSigInInSuccess(withServerAuthCode:  serverAuthCode)
//			}else{
//				serviceable?.googleSignInFailed(error: error?.localizedDescription ?? "")
//			}
//		}
//	}
	
}


// MARK: Initialization

extension MicrosoftSignInService {
	
	/**
	 
	 Initialize a MSALPublicClientApplication with a given clientID and authority
	 
	 - clientId:            The clientID of your application, you should get this from the app portal.
	 - redirectUri:         A redirect URI of your application, you should get this from the app portal.
	 If nil, MSAL will create one by default. i.e./ msauth.<bundleID>://auth
	 - authority:           A URL indicating a directory that MSAL can use to obtain tokens. In Azure AD
	 it is of the form https://<instance/<tenant>, where <instance> is the
	 directory host (e.g. https://login.microsoftonline.com) and <tenant> is a
	 identifier within the directory itself (e.g. a domain associated to the
	 tenant, such as contoso.onmicrosoft.com, or the GUID representing the
	 TenantID property of the directory)
	 - error                The error that occurred creating the application object, if any, if you're
	 not interested in the specific error pass in nil.
	 */
	func initMSAL() throws {
		
		var _authority = Config.shared.msalAuthority
		var clientID = Config.shared.msalClientID
		var redirectUri = Config.shared.msalRedirectURI
		
		guard let authorityURL = URL(string: _authority) else {
			print("Unable to create authority URL")
			return
		}
		
		let authority = try MSALAADAuthority(url: authorityURL)
		
		let msalConfiguration = MSALPublicClientApplicationConfig(clientId: clientID,
																  redirectUri: redirectUri,
																  authority: authority)
		self.applicationContext = try MSALPublicClientApplication(configuration: msalConfiguration)
		self.initWebViewParams()
	}
	
	func initWebViewParams() {
		self.webViewParamaters = MSALWebviewParameters(authPresentationViewController: viewController!)
	}
}

// MARK: Acquiring and using token

extension MicrosoftSignInService {
	
	/**
	 This will invoke the authorization flow.
	 */
	
//	@objc func callGraphAPI(_ sender: UIButton) {
//
//		self.loadCurrentAccount { (account) in
//
//			guard let currentAccount = account else {
//
//				// We check to see if we have a current logged in account.
//				// If we don't, then we need to sign someone in.
//				self.acquireTokenInteractively()
//				return
//			}
//
//			self.acquireTokenSilently(currentAccount)
//		}
//	}
	
	func acquireTokenInteractively() {
		
		guard let applicationContext = self.applicationContext else { return }
		guard let webViewParameters = self.webViewParamaters else { return }

		let parameters = MSALInteractiveTokenParameters(scopes: kScopes, webviewParameters: webViewParameters)
		parameters.promptType = .selectAccount
		
		applicationContext.acquireToken(with: parameters) { (result, error) in
			
			if let error = error {
				
				print("Could not acquire token: \(error)")
				return
			}
			
			guard let result = result else {
				
				print("Could not acquire token: No result returned")
				return
			}
			
			self.accessToken = result.accessToken
			print("Access token is :\(self.accessToken)")
//			self.updateCurrentAccount(account: result.account)
			self.getContentWithToken()
		}
	}
	
	func getGraphEndpoint() -> String {
		return Config.shared.msalGraphEndpoint.hasSuffix("/") ? (Config.shared.msalGraphEndpoint + "v1.0/me/") : (Config.shared.msalGraphEndpoint + "/v1.0/me/");
	}
	
	/**
	 This will invoke the call to the Microsoft Graph API. It uses the
	 built in URLSession to create a connection.
	 */
	
	func getContentWithToken() {
		
		// Specify the Graph API endpoint
		let graphURI = getGraphEndpoint()
		let url = URL(string: graphURI)
		var request = URLRequest(url: url!)
		
		// Set the Authorization header for the request. We use Bearer tokens, so we specify Bearer + the token we got from the result
		request.setValue("Bearer \(self.accessToken)", forHTTPHeaderField: "Authorization")
		print("Access token is :\(self.accessToken)")
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let error = error {
				print("Couldn't get graph result: \(error)")
				return
			}
			
			guard let result = try? JSONSerialization.jsonObject(with: data!, options: []) else {
				
				print("Couldn't deserialize result JSON")
				return
			}
			
			print("Result from Graph: \(result))")
			
			}.resume()
	}

}


