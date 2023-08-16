//  
//  AppDelegate.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import UIKit
import Sentry
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var firebaseManager: FirebaseManager!
    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		initSentry()

//		initFirebase(application: application)

		Config.shared.showInfo()

		initFirstTimeInstall()

		initWindow()

		initIQKeyboardManager()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

	// MARK: - Notification Handling (iOS <= 11)

	// [START receive_message]
	func application(_ application: UIApplication,
					 didReceiveRemoteNotification userInfo: FirebaseNotificationUserInfo) {
		firebaseManager.handleNotification(userInfo: userInfo)
	}

	func application(_ application: UIApplication,
					 didReceiveRemoteNotification userInfo: FirebaseNotificationUserInfo,
					 fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		firebaseManager.handleNotification(userInfo: userInfo)
		completionHandler(UIBackgroundFetchResult.newData)
	}
	// [END receive_message]

	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
	  print("Unable to register for remote notifications: \(error.localizedDescription)")
	}


}

extension AppDelegate {

	func initSentry() {

		SentrySDK.start { options in
			options.dsn = Config.shared.sentryDSN
			options.environment = Config.shared.sentryEnvironmentName
			options.debug = true // Enabled debug when first installing is always helpful
		}

	}

}

extension AppDelegate {

	func initFirebase(application: UIApplication) {
		firebaseManager = FirebaseManager(application: application)
		firebaseManager.configure()
	}

}

extension AppDelegate {

    private func initFirstTimeInstall() {
        let defaults = DefaultsHelper.shared
        if !defaults.hasInitializedFreshInstall {
            let keychain = KeychainHelper.shared
            keychain.clear()
            defaults.hasInitializedFreshInstall = true
            print("This app is a fresh installation.")
        }
    }

    private func initWindow() {

        window = UIWindow(frame: UIScreen.main.bounds)
        mainCoordinator = MainCoordinator()

        window?.rootViewController = mainCoordinator?.navigationVc
        window?.makeKeyAndVisible()
        mainCoordinator?.start()
    }


}

extension AppDelegate {
    
    func initIQKeyboardManager() {
        IQKeyboardManager.shared().isEnabled = true
    }

}
