//
//  SceneDelegate.swift
//  T_Pro_Intercom
//
//  Created by Pedro Paulo de Amorim on 19/12/2019.
//  Copyright © 2019 T-Pro. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  
  deinit {
    window = nil
  }

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene: UIWindowScene = scene as? UIWindowScene else {
      return
    }

    guard let sceneDelegate: SceneDelegate = windowScene.delegate as? SceneDelegate else {
      return
    }

    let statusBarFrame: CGRect = windowScene.statusBarManager!.statusBarFrame

    sceneDelegate.window = buildView(windowScene: windowScene)

    setupViewController(
      sceneDelegate.window,
      statusBarFrame,
      windowScene)
  }

  func windowScene(
    _ windowScene: UIWindowScene,
    performActionFor shortcutItem: UIApplicationShortcutItem,
    completionHandler: @escaping (Bool) -> Void) {
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
//    unblurPresentedView()
    becomeFirstResponder()
    UIApplication.shared.beginReceivingRemoteControlEvents()
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
//    unblurPresentedView()
    becomeFirstResponder()
    UIApplication.shared.beginReceivingRemoteControlEvents()
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    UIApplication.shared.endReceivingRemoteControlEvents()
    UIApplication.shared.ignoreSnapshotOnNextApplicationLaunch()
//    blurPresentedView()
    resignFirstResponder()
  }

  func sceneWillResignActive(_ scene: UIScene) {
    UIApplication.shared.ignoreSnapshotOnNextApplicationLaunch()
//    blurPresentedView()
  }

  func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
  }

}
