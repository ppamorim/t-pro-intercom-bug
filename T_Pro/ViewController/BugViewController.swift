//
//  TaskHistoryViewController.swift
//  T_Pro_Intercom
//
//  Created by Pedro Paulo de Amorim on 19/12/2019.
//  Copyright © 2019 T-Pro. All rights reserved.
//

import UIKit
import Crashlytics
import AudioToolbox.AudioServices

final class BugViewController: BaseViewController {

  private lazy var closeAppLabel: UILabel = {
    let width: CGFloat = 300
    let height: CGFloat = 80
    //No constraint layout now sorry, to be quick
    let button = UILabel(frame: CGRect(x: self.view.frame.width/2 - width/2, y: self.view.frame.height/2 - height/2, width: width, height: height))
    button.text = "Please close the app and open it again"
    return button
  }()

  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    super.loadView { [weak self] in
      self?.view.backgroundColor = UIColor.yellow
      self?.view.addSubview(closeAppLabel)
    }
  }

}
