//
//  MainMenu.swift
//  SpaceShooter
//
//  Created by Игорь Солодянкин on 20.01.2023.
//

import SpriteKit

class MainMenu: SKScene {

    var starfield: SKEmitterNode!
    
    var newGameButtonNode: SKSpriteNode!
    var levelButtonButtonNode: SKSpriteNode!
    var shuttleButton: SKSpriteNode!
    var shuttleImage: SKSpriteNode!
    
    var labelLevelNode: SKLabelNode!
    var labelShuttleNode: SKLabelNode!
    
    override func didMove(to view: SKView) {
        starfield = self.childNode(withName: "starfield_anim") as! SKEmitterNode
        starfield.advanceSimulationTime(30)
        
        newGameButtonNode = self.childNode(withName: "newGameButton") as! SKSpriteNode
        newGameButtonNode.texture = SKTexture(imageNamed: "newGameButton")
        
        levelButtonButtonNode = self.childNode(withName: "levelButton") as! SKSpriteNode
        levelButtonButtonNode.texture = SKTexture(imageNamed: "levelButton")
        
        shuttleButton = self.childNode(withName: "shuttleButton") as! SKSpriteNode
        shuttleButton.texture = SKTexture(imageNamed: "shuttleButton")
        
        shuttleImage = self.childNode(withName: "shuttleImage") as! SKSpriteNode
        shuttleImage.texture = SKTexture(imageNamed: "shuttle")
        
        labelLevelNode = self.childNode(withName: "labelLevelButton") as! SKLabelNode
        labelShuttleNode = self.childNode(withName: "labelShuttleButton") as! SKLabelNode
        
        let userLevel = UserDefaults.standard
        let shuttle = UserDefaults.standard
        
        if userLevel.bool(forKey: "hard") {
            labelLevelNode.text = "Сложно"
        } else {
            labelLevelNode.text = "Легко"
        }
        
        if userLevel.bool(forKey: "hunter") {
            labelShuttleNode.text = "Охотник"
        } else {
            labelShuttleNode.text = "Разведчик"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodes = self.nodes(at: location)
            
            if nodes.first?.name == "newGameButton" {
                let transition = SKTransition.flipVertical(withDuration: 0.5)
                let gameScene = GameScene(size: UIScreen.main.bounds.size)
                self.view?.presentScene(gameScene, transition: transition)
            } else if nodes.first?.name == "levelButton" {
                changeLevel()
            } else if nodes.first?.name == "shuttleButton" {
                changeShuttle()
            }
        }
    }
    
    func changeLevel() {
        let userLevel = UserDefaults.standard
        
        if labelLevelNode.text == "Легко" {
            labelLevelNode.text = "Сложно"
            userLevel.set(true, forKey: "hard")
        } else {
            labelLevelNode.text = "Легко"
            userLevel.set(false, forKey: "hard")
        }
        userLevel.synchronize()
    }
    
    func changeShuttle() {
        let shuttle = UserDefaults.standard
        
        if labelShuttleNode.text == "Разведчик" {
            labelShuttleNode.text = "Охотник"
            shuttle.set(true, forKey: "hunter")
            shuttleImage.texture = SKTexture(imageNamed: "shuttle")
        } else {
            labelShuttleNode.text = "Разведчик"
            shuttle.set(false, forKey: "hunter")
            shuttleImage.texture = SKTexture(imageNamed: "shuttle2")
        }
        shuttle.synchronize()
        
    }
    
}
