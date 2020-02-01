//
//  GameScene.swift
//  bugtest
//
//  Created by David Long on 9/30/19.
//  Copyright © 2019 David Long. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  var x = CGFloat(-200)

  func addShip(_ texture: SKTexture, how: String) {
    let sprite = SKSpriteNode(texture: texture)
    sprite.position = CGPoint(x: x, y: 0)
    sprite.zRotation = .pi / 4
    x += 100
    sprite.physicsBody = SKPhysicsBody(texture: texture, size: sprite.size)
    if sprite.physicsBody == nil {
      print("\(how) failed")
    } else {
      print("\(how) worked")
    }
    addChild(sprite)
  }

  override func didMove(to view: SKView) {
    // The atlas version of a texture
    addShip(SKTexture(imageNamed: "ship_blue"), how: "simple atlas reference")
    // From an atlas, but call size() to force loading
    let texture = SKTexture(imageNamed: "ship_blue")
    _ = texture.size()
    addShip(SKTexture(imageNamed: "ship_blue"), how: "atlas force load")
    // Reconstruct via CGImage (size would be wrong because of 2x)
    let cgTexture = SKTexture(cgImage: texture.cgImage())
    addShip(cgTexture, how: "reconstruct via cgImage")
    // Re-render using view
    let renderedTexture = view.texture(from: SKSpriteNode(texture: texture))!
    addShip(renderedTexture, how: "re-render using view")
    // Non-atlas texture
    addShip(SKTexture(imageNamed: "nonatlas_ship_blue"), how: "not in atlas")
  }

  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
  }

  override init(size: CGSize) {
    super.init(size: size)
    physicsWorld.gravity = .zero
    physicsWorld.contactDelegate = self
    anchorPoint = CGPoint(x: 0.5, y: 0.5)
  }

  required init(coder aDecoder: NSCoder) {
    fatalError()
  }
}
