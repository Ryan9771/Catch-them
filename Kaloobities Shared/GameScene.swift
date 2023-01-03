//
//  GameScene.swift
//  Kaloobities Shared
//
//  Created by Ryan Patel on 3/1/23.
//

import SpriteKit

class GameScene: SKScene {
    
    let basket = SKSpriteNode(imageNamed: "basket")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        basket.position = CGPoint(x: size.width / 2, y: size.height / 4)
        basket.size = CGSize(width: 200, height: 100)
        addChild(basket)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
        basket.physicsBody = SKPhysicsBody(rectangleOf: basket.size)
        
        basket.physicsBody?.isDynamic = false
        
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
        
        self.addChild(ball)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // To do
    }
    
    
    
    
    
    
}
