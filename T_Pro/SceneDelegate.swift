//
//  SceneDelegate.swift
//  T_Pro_Intercom
//
//  Created by Pedro Paulo de Amorim on 19/12/2019.
//  Copyright © 2019 T-Pro. All rights reserved.
//

import UIKit
import Intercom

private let blurViewtag: Int = 198489

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
    
    Intercom.setApiKey(INTERCOM_API_KEY, forAppId: INTERCOM_APP_ID)
    Intercom.setLauncherVisible(false)
  }

  func windowScene(
    _ windowScene: UIWindowScene,
    performActionFor shortcutItem: UIApplicationShortcutItem,
    completionHandler: @escaping (Bool) -> Void) {
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    unblurPresentedView()
    becomeFirstResponder()
    UIApplication.shared.beginReceivingRemoteControlEvents()
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    unblurPresentedView()
    becomeFirstResponder()
    UIApplication.shared.beginReceivingRemoteControlEvents()
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    UIApplication.shared.endReceivingRemoteControlEvents()
    UIApplication.shared.ignoreSnapshotOnNextApplicationLaunch()
    blurPresentedView()
    resignFirstResponder()
  }

  func sceneWillResignActive(_ scene: UIScene) {
    UIApplication.shared.ignoreSnapshotOnNextApplicationLaunch()
    blurPresentedView()
  }

  func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
  }

}

@available(iOS 13.0, *)
extension SceneDelegate {

  func blurPresentedView() {
    UIApplication.shared.connectedScenes.forEach { (scene: UIScene) in

      if let window: UIWindow = (scene.delegate as? SceneDelegate)?.window,
        window.viewWithTag(blurViewtag) == nil,
        let snapshot: UIView = bluredSnapshot(window) {

        snapshot.alpha = 0.1
        window.addSubview(snapshot)
        UIView.animate(withDuration: 0.2) {
          snapshot.alpha = 1.0
        }

      }

    }
  }

  func unblurPresentedView() {

    UIApplication.shared.connectedScenes.forEach { (scene: UIScene) in

      if let window: UIWindow = (scene.delegate as? SceneDelegate)?.window,
        let view: UIView = window.viewWithTag(blurViewtag) {

        UIView.animate(withDuration: 0.2, animations: {
          view.alpha = 0.0
        }, completion: { _ in
          view.removeFromSuperview()
        })

      }

    }
  }

  func bluredSnapshot(_ window: UIWindow?) -> UIView? {

    guard let snapshot: UIView = window?.snapshotView(afterScreenUpdates: true) else {
      return nil
    }

    snapshot.addSubview(blurView(frame: snapshot.frame))
    snapshot.tag = blurViewtag

    return snapshot
  }

  func blurView(frame: CGRect) -> UIView {
    let view: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    view.frame = frame
    return view
  }

}
