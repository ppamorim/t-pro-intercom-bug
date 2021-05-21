//
//  HomeViewController.swift
//  T_Pro_Intercom
//
//  Created by Pedro Paulo de Amorim on 19/12/2019.
//  Copyright © 2019 T-Pro. All rights reserved.
//

import UIKit
import AVFoundation
import Crashlytics
import Intercom

final class HomeViewController: UIPageViewController {

  private lazy var bugMeButton: UIButton = {
    let width: CGFloat = 100
    let height: CGFloat = 40
    //No constraint layout now sorry, to be quick
    let button = UIButton(frame: CGRect(x: self.view.frame.width/2 - width/2, y: self.view.frame.height/2 - height/2, width: width, height: height))
    button.setTitle("Bug me", for: .normal)
    button.backgroundColor = UIColor.blue
    return button
  }()

  init(transitionStyle: UIPageViewController.TransitionStyle) {
    super.init(transitionStyle: transitionStyle, navigationOrientation: .horizontal, options: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    super.loadView()
    view.backgroundColor = UIColor.white
    view.addSubview(bugMeButton)
  }

  override func viewDidLoad() {
    bugMeButton.addTarget(self, action: #selector(bugMeTouchUp), for: .touchUpInside)

    Intercom.registerUser(withUserId: "101", email: "tpro_intercom_ios@tpro.io")
    Intercom.setUserHash("8e02316cdca654b5864409b8e28155b9")

//    Intercom.logout()
  }

  @objc
  private func bugMeTouchUp() {
    let bugViewController: BugViewController = BugViewController()
    self.parent?.present(bugViewController, animated: true)
  }

}
