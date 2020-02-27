//
//  BaseViewController.swift
//  T_Pro_Intercom
//
//  Created by Pedro Paulo de Amorim on 19/12/2019.
//  Copyright © 2019 T-Pro. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  private(set) var didViewReady: Bool = false

  /**
   * Configures the initial parameters of the view.
   */
  func loadView(_ addViews: () -> Void) {
    super.loadView()
    addViews()
    view.setNeedsUpdateConstraints()
  }

  /**
   * Configure the constraints of the view, check the class
   * QueueViewControllerConstraints.
   */
  func updateViewConstraints(
      _ buildConstraints: () -> Void,
      animationConstraints: (() -> Swift.Void)? = nil) {
    if !didViewReady {
      buildConstraints()
      didViewReady = true
    }
    animationConstraints?()
    super.updateViewConstraints()
  }

}
