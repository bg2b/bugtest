//
//  GameViewController.swift
//  bugtest
//
//  Created by David Long on 9/30/19.
//  Copyright © 2019 David Long. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    if let view = self.view as! SKView? {
      let scene = GameScene(size: CGSize(width: 500, height: 500))
      scene.scaleMode = .aspectFit
      view.presentScene(scene)
      view.ignoresSiblingOrder = true
      view.showsPhysics = true
    }
  }

  override var shouldAutorotate: Bool {
    return true
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }

  override var prefersStatusBarHidden: Bool {
    return true
  }
}
