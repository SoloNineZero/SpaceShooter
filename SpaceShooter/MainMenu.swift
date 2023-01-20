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
    var labelLevelNode: SKLabelNode!
    
    override func didMove(to view: SKView) {
        starfield = self.childNode(withName: "starfield_anim") as! SKEmitterNode
        starfield.advanceSimulationTime(30)
        
        newGameButtonNode = self.childNode(withName: "newGameButton") as! SKSpriteNode
        newGameButtonNode.texture = SKTexture(imageNamed: "newGameButton")
        
        levelButtonButtonNode = self.childNode(withName: "levelButton") as! SKSpriteNode
        levelButtonButtonNode.texture = SKTexture(imageNamed: "levelButton")
        
        labelLevelNode = self.childNode(withName: "labelLevelButton") as! SKLabelNode
        
        let userLevel = UserDefaults.standard
        
        if userLevel.bool(forKey: "hard") {
            labelLevelNode.text = "Сложно"
        } else {
            labelLevelNode.text = "Легко"
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
    
}
