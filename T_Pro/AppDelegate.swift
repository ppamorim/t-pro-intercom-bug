//
//  AppDelegate.swift
//  T_Pro_Intercom
//
//  Created by Pedro Paulo de Amorim on 19/12/2019.
//  Copyright © 2019 T-Pro. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import Fabric
import Crashlytics
import Intercom

private let INTERCOM_APP_ID: String = "ddddddd"
private let INTERCOM_API_KEY: String = "ios_sdk-"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  private(set) var orientationLock: UIInterfaceOrientationMask = {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return [.portrait, .portraitUpsideDown]
    }
    return .all
  }()

  deinit {
    window = nil
  }

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    setupFabric()
    setupIntercom()
    buildViewForWindow(launchOptions)
    becomeFirstResponder()
    application.beginReceivingRemoteControlEvents()

    return true
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
//    unblurPresentedView()
    becomeFirstResponder()
    application.beginReceivingRemoteControlEvents()
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    application.endReceivingRemoteControlEvents()
    application.ignoreSnapshotOnNextApplicationLaunch()
//    blurPresentedView()
    resignFirstResponder()
  }

  func applicationWillResignActive(_ application: UIApplication) {
    application.ignoreSnapshotOnNextApplicationLaunch()
//    blurPresentedView()
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
//    unblurPresentedView()
  }

  func applicationWillTerminate(_ application: UIApplication) {

  }

  func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
    application.presentLocalNotificationNow(notification)
  }

  public func application(
      _ application: UIApplication,
      handleEventsForBackgroundURLSession identifier: String,
      completionHandler: @escaping () -> Void) {
  }

  func application(
      _ application: UIApplication,
      supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    self.orientationLock
  }

  func application(
    _ application: UIApplication,
    performActionFor shortcutItem: UIApplicationShortcutItem,
    completionHandler: @escaping (Bool) -> Void) {

  }

  func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    return true
  }

  // MARK: UISceneSession Lifecycle

  @available(iOS 13.0, *)
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  @available(iOS 13.0, *)
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }

  override var canBecomeFirstResponder: Bool {
    true
  }

  //Handle event
  override func remoteControlReceived(with event: UIEvent?) {
    super.remoteControlReceived(with: event)
  }

  func buildViewForWindow(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    if #available(iOS 13.0, *) {
      return
    }
    self.window = buildViewForUIScreen()
    setupViewController(
      self.window,
      CGRect.zero,
      nil)
  }

  func refreshView() {
    self.buildViewForWindow(nil)
  }

  func updateRotationLock(_ orientationLock: UIInterfaceOrientationMask) {
    self.orientationLock = orientationLock
  }

}

extension AppDelegate {

	/**
	Fabric setup
	*/
  fileprivate func setupFabric() {
		Fabric.with([Crashlytics.self])
		Fabric.sharedSDK().debug = false
	}

  fileprivate func setupIntercom() {
    Intercom.setApiKey(INTERCOM_API_KEY, forAppId: INTERCOM_APP_ID)
    Intercom.setLauncherVisible(false)
  }

}

extension AppDelegate {

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Intercom.setDeviceToken(deviceToken)
  }

  /**
   If you are receiving a notification message while your app is in the background,
   this callback will not be fired till the user taps on the notification launching the application.
   */
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    guard #available(iOS 10.0, *) else {
      self.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: { _ in })
      return
    }
  }

  func application(
      _ application: UIApplication,
      didReceiveRemoteNotification userInfo: [AnyHashable: Any],
      fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
  }

  // [END connect_to_fcm]
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    
  }

}

// [START ios_10_message_handling]
@available(iOS 10.0, *)
extension AppDelegate: UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(
      _ center: UNUserNotificationCenter,
      willPresent notification: UNNotification,
      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([])
  }

  func userNotificationCenter(
      _ center: UNUserNotificationCenter,
      didReceive response: UNNotificationResponse,
      withCompletionHandler completionHandler: @escaping () -> Void) {
    completionHandler()
  }
}
