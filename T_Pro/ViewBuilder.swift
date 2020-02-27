//
//  ViewBuilder.swift
//  T_Pro_Intercom
//
//  Created by Pedro Paulo de Amorim on 19/12/2019.
//  Copyright © 2019 T-Pro. All rights reserved.
//

import Foundation
import UIKit

func buildViewForUIScreen() -> UIWindow? {
  if #available(iOS 13.0, *) {
    return nil
  }
  let frame: CGRect = UIApplication.shared.keyWindow?.bounds ?? UIScreen.main.bounds
  return UIWindow(frame: frame)
}

/**
 Load the ViewController on the application window.
 */
@available(iOS 13.0, *)
func buildView(windowScene: UIWindowScene) -> UIWindow? {
  return UIWindow(windowScene: windowScene)
}

func setupViewController(
  _ window: UIWindow?,
  _ statusBarFrame: CGRect,
  _ windowScene: Any?) {

  guard let window: UIWindow = window else {
    return
  }

  setupWindow(window)

  let homeViewController: HomeViewController = HomeViewController(
    transitionStyle: UIPageViewController.TransitionStyle.scroll)

  homeViewController.modalPresentationStyle = .fullScreen

  window.rootViewController = setupViewForPhone(homeViewController)
  window.makeKeyAndVisible()
}

private func setupWindow(_ window: UIWindow?) {
  window?.isHidden = false
}

private func setupViewForPhone(_ homeViewController: HomeViewController) -> UIViewController {
  let navigationViewController: UILockedUINavigationController = UILockedUINavigationController(
    rootViewController: homeViewController)
  navigationViewController.isNavigationBarHidden = true
  navigationViewController.modalPresentationStyle = .fullScreen
  return navigationViewController
}
