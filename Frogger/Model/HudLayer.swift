//
//  HudLayer.swift
//  Frogger
//
//  Created by Rodrigo Franzoi Scroferneker on 09/12/17.
//  Copyright © 2017 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import SpriteKit

class HudLayer: SKSpriteNode {
    
    private var score : Int
    private var lifes : Int
    
    var scoreLabel : SKLabelNode
    var lifesLabel : SKLabelNode
    
    init(screenSize : CGSize) {
    
        self.score = 0
        self.lifes = 3
        
        self.scoreLabel = SKLabelNode(text: "Pontuação: " + self.score.description)
        self.scoreLabel.position = CGPoint(x: screenSize.height/2 - 100, y: screenSize.height/2 - 60)
        self.scoreLabel.zPosition = 11
        
        self.lifesLabel = SKLabelNode(text: "Vidas: " + self.lifes.description)
        self.lifesLabel.position = CGPoint(x: -screenSize.width/2 + 100, y: screenSize.height/2 - 60)
        self.lifesLabel.zPosition = 11
        
        super.init(texture: nil, color: .clear, size: screenSize)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 10
        
        self.addChild(lifesLabel)
        self.addChild(scoreLabel)
    }
    
    public func setLifes(_ lifes: Int = 1) {
        self.lifes += lifes
        self.lifesLabel.text = "Vidas: " + self.lifes.description
    }
    
    public func setScore(_ score: Int) {
        self.score += score
        self.scoreLabel.text = "Pontuação: " + self.score.description
    }
    
    public func getScore() -> Int{
        return score
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
