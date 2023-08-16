//  
//  FirebaseManager.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

/* FCM Setup Checklist (assuming that there's already an existing firebase project setup)

in the App:
 - Add "remote-notification" to remote-notification in Info.plist
 - Tick "Push Notifications" in Background Modes, in Signing & Capabilities
 - Add the "Push Notifications" capability

in Firebase Console:
 - Upload .p8 file to Firebase

in the Developer Account:
 - Configuring push notifications in Certfificates, Identifiers & Profiles > Identifiers > (app bundle id) > Push Notifications > Configure
*/


import Foundation
import UIKit
import Firebase

typealias FirebaseNotificationUserInfo = [AnyHashable: Any]

class FirebaseManager: NSObject {

	let gcmMessageIDKey = "gcm.message_id"
	let application: UIApplication

	init(application: UIApplication) {
		self.application = application
	}

}

extension FirebaseManager {

	public func configure() {
		FirebaseApp.configure()
		Messaging.messaging().delegate = self

		if #available(iOS 10.0, *) {

			UNUserNotificationCenter.current().delegate = self
			let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]

			func requestAuthorizationCompletionHandler(granted: Bool, error: Error?) {
				print(#file)
				print(granted)
				print(error ?? "no error")
			}

			UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: requestAuthorizationCompletionHandler)

		} else {
			let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
			application.registerUserNotificationSettings(settings)
		}

		application.registerForRemoteNotifications()

	}

	public func handleNotification(userInfo: FirebaseNotificationUserInfo) {
		dump(userInfo)
	}

}

// MARK: - iOS 10 Message Handling
extension FirebaseManager: UNUserNotificationCenterDelegate {

	// Asks the delegate how to handle a notification that arrived while the app was running in the foreground.
	func userNotificationCenter(_ center: UNUserNotificationCenter,
								willPresent notification: UNNotification,
								withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

		let userInfo = notification.request.content.userInfo
		// With swizzling disabled you must let Messaging know about the message, for Analytics
		// Messaging.messaging().appDidReceiveMessage(userInfo)
		// Print message ID.
		if let messageId = userInfo[gcmMessageIDKey] {
			print("message id: \(messageId)")
		}
		handleNotification(userInfo: userInfo)
		completionHandler([.alert, .sound])
	}

 //	Asks the delegate to process the user's response to a delivered notification
	func userNotificationCenter(_ center: UNUserNotificationCenter,
								didReceive response: UNNotificationResponse,
								withCompletionHandler completionHandler: @escaping () -> Void) {
		let userInfo = response.notification.request.content.userInfo
		if let messageID = userInfo[gcmMessageIDKey] {
			print("Message ID: \(messageID)")
		}
		handleNotification(userInfo: userInfo)
		completionHandler()
	}

}
// MARK: - end of iOS 10 Message Handling

extension FirebaseManager: MessagingDelegate {
	// [START refresh_token]
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
		print("Firebase registration token: \(fcmToken)")

		let dataDict:[String: String] = ["token": fcmToken]
		NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
		// TODO: If necessary send token to application server.
		// Note: This callback is fired at each app startup and whenever a new token is generated.
	}
	// [END refresh_token]

}

