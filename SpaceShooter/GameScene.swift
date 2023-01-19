//
//  GameScene.swift
//  SpaceShooter
//
//  Created by Игорь Солодянкин on 19.01.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Счёт: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 1472)
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "shuttle")
        player.position = CGPoint(x: 0, y: -400)
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0) // физика отключена
        self.physicsWorld.contactDelegate = self // соприкосновние в игре
        
        scoreLabel = SKLabelNode(text: "Счёт: 0")
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = CGPoint(x: -200, y: 500)
        score = 0
        
        self.addChild(scoreLabel)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
