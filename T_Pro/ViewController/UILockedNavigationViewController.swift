//
//  UILockedNavigationViewController.swift
//  T_Pro_Intercom
//
//  Created by Pedro Paulo de Amorim on 26/02/2020.
//  Copyright © 2020 T-Pro. All rights reserved.
//

import Foundation
import UIKit

class UILockedUINavigationController: UINavigationController {

  override var shouldAutorotate: Bool {
    UIDevice.current.userInterfaceIdiom != .phone
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    UIDevice.current.userInterfaceIdiom == .phone ? [.portrait, .portraitUpsideDown] : .all
  }

  override var childForStatusBarStyle: UIViewController? {
    topViewController
  }

}
