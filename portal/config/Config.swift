//  
//  Config.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation

struct Config: Decodable {

	static let shared: Config = {
		let infoPlist = Bundle.main.infoDictionary!
		let jsonData = try! JSONSerialization.data(withJSONObject: infoPlist, options: .prettyPrinted)
		return try! JSONDecoder().decode(Config.self, from: jsonData)
	}()

	var baseURL: URL
	var namespace: String
	var sentryDSN: String
	var sentryEnvironmentName: String
	var clientId: String
    var clientSecret: String
    var clientScope: String
	
	enum CodingKeys: String, CodingKey {
		case baseURL = "API_BASE_URL"
		case namespace = "APP_NAMESPACE"

		case sentryDSN = "SENTRY_DSN"
		case sentryEnvironmentName = "SENTRY_ENV"

        case clientId = "CLIENT_ID"
        case clientSecret = "CLIENT_SECRET"
        case clientScope = "CLIENT_SCOPE"
	}

}

extension Config {

	func showInfo() {
		let linesToPrint = [
			"APPINFO:",
			"Base URL: \(baseURL.absoluteString)",
			"Namespace: \(namespace)",
			"FCM Token: ???"
		]
		let longestLineLength = (linesToPrint.map { return $0.count }).max() ?? 0

		let topBorder = String(repeating: "*", count: longestLineLength + 4)
		let bottomBorder = topBorder
		print(topBorder)
		linesToPrint.forEach { printWithPadding($0, longestLineCount: longestLineLength) }
		print(bottomBorder)
	}

	private func printWithPadding(_ line: String, longestLineCount: Int) {
		print("* \(line)\(String(repeating: " ", count: longestLineCount - line.count)) *")
	}

}


