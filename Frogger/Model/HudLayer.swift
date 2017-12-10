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
    
    var scoreLabel : SKLabelNode
    var scoreShadow : SKLabelNode
    
    var lifesLabel : SKLabelNode
    var lifesShadow : SKLabelNode
    
    init(screenSize : CGSize) {
    
        self.score = 0
        
        self.scoreLabel = SKLabelNode(text: "Score: " + self.score.description)
        self.scoreLabel.fontName = "Early-GameBoy"
        self.scoreLabel.fontSize = 20
        self.scoreLabel.position = CGPoint(x: screenSize.height/2 - 100, y: screenSize.height/2 - 40)
        self.scoreLabel.zPosition = 11
        
        self.scoreShadow = SKLabelNode(text: "Score: " + self.score.description)
        self.scoreShadow.fontName = "Early-GameBoy"
        self.scoreShadow.fontSize = 20
        self.scoreShadow.fontColor = .black
        self.scoreShadow.position = CGPoint(x: screenSize.height/2 - 98, y: screenSize.height/2 - 42)
        self.scoreShadow.zPosition = 10
        
        
        self.lifesLabel = SKLabelNode(text: "Lifes: 3")
        self.lifesLabel.fontName = "Early-GameBoy"
        self.lifesLabel.fontSize = 20
        self.lifesLabel.position = CGPoint(x: -screenSize.width/2 + 100, y: screenSize.height/2 - 40)
        self.lifesLabel.zPosition = 11
        
        self.lifesShadow = SKLabelNode(text: "Lifes: 3")
        self.lifesShadow.fontName = "Early-GameBoy"
        self.lifesShadow.fontSize = 20
        self.lifesShadow.fontColor = .black
        self.lifesShadow.position = CGPoint(x: -screenSize.width/2 + 102, y: screenSize.height/2 - 42)
        self.lifesShadow.zPosition = 10
        
        super.init(texture: nil, color: .clear, size: screenSize)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 10
        
        self.addChild(scoreShadow)
        self.addChild(lifesShadow)
        self.addChild(lifesLabel)
        self.addChild(scoreLabel)
    }
    
    public func setLifes(_ lifes: Int = 1) {
        self.lifesLabel.text = "lifes: " + lifes.description
        self.lifesShadow.text = "lifes: " + lifes.description
    }
    
    public func setScore(_ score: Int) {
        self.score += score
        self.scoreLabel.text = "score: " + self.score.description
        self.scoreShadow.text = "score: " + self.score.description
    }
    
    public func getScore() -> Int{
        return score
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
