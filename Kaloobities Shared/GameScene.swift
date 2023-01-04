//
//  GameScene.swift
//  Kaloobities Shared
//
//  Created by Ryan Patel on 3/1/23.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let basket = SKSpriteNode(imageNamed: "basket")
    var score = 0
    var scoreLabel: SKLabelNode!
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        backgroundColor = SKColor.white
        basket.position = CGPoint(x: size.width / 2, y: size.height / 4)
        basket.size = CGSize(width: 200, height: 100)
        addChild(basket)
        
        // Sets up the score label
        scoreLabel = SKLabelNode(fontNamed: "Helvetica")
        scoreLabel.fontColor = SKColor.brown
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: frame.size.width - 80, y: frame.size.height - 100)
        self.addChild(scoreLabel)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
        basket.physicsBody = SKPhysicsBody(rectangleOf: basket.size)
        
        basket.physicsBody!.isDynamic = false
        basket.physicsBody!.categoryBitMask = 1
        basket.physicsBody!.contactTestBitMask = 1 | 2
        
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { timer in
            self.addBall()
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Get the first touch object.
        guard let touch = touches.first else { return }

        // Get the current and previous position of the touch.
        let currentPosition = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)

        // Calculate the amount that the finger has moved horizontally.
        let dx = currentPosition.x - previousPosition.x

        // Update the position of the basket by moving it horizontally by the amount that the finger has moved.
        
        if (basket.position.x + dx < size.width && basket.position.x + dx > 0) {
            
            basket.position.x += dx
        }
      }
    
    
    func addBall() {
        let ball = SKSpriteNode(imageNamed: "ball")
        
        let xPos = CGFloat.random(in: 0..<self.frame.width)
        
        let yPos = self.frame.height + ball.size.height
        
        ball.position = CGPoint(x: xPos, y: yPos)
        
        ball.size = CGSize(width: 60, height: 60)
        
        ball.name = "ball"
        ball.physicsBody?.categoryBitMask = 2
        ball.physicsBody?.contactTestBitMask = 1 | 2
        
        self.addChild(ball)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        
    }
    
   
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "ball" || contact.bodyB.node?.name == "ball" {
            score += 1
            scoreLabel.text = "\(score)"
            contact.bodyB.node?.removeFromParent()
        }
    }
    
    
}

//extension GameScene: SKPhysicsContactDelegate {
//  func physicsBody(_ bodyA: SKPhysicsBody, didBegin contact: SKPhysicsContact) {
//      print("Collision detected")
//      // Check if bodyA is a bird and bodyB is the basket, or vice versa.
//      if (bodyA.categoryBitMask == 0x1 << 1 && contact.bodyB.categoryBitMask == 0x1 << 0) ||
//            (bodyA.categoryBitMask == 0x1 << 0 && contact.bodyB.categoryBitMask == 0x1 << 1) {
//          // Increase the player's score.
//          score += 1
//
//          print(score)
//
//          // Update the score label.
//          scoreLabel.text = "\(score)"
//
//          // Remove the bird from the scene.
//          bodyA.node?.removeFromParent()
//    }
//  }
