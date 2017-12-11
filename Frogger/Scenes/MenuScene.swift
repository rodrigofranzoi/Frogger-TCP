//
//  MenuScene.swift
//  Frogger
//
//  Created by Rodrigo Franzoi Scroferneker on 09/12/17.
//  Copyright © 2017 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import SpriteKit

protocol MenuDelegate {
    func playGame()
}

class MenuScene: SKScene, ButtonDelegate {
    
    var menuDelegate : MenuDelegate!
    var playButton : ButtonNode!
    var scoreBox : SKSpriteNode!
    
    
    
    override func didMove(to view: SKView) {
    
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        scoreBox = SKSpriteNode(texture: nil, color: .blue, size: CGSize(width: self.size.width/2 - 40, height:  self.size.height - 40))
        scoreBox.position = CGPoint(x: self.size.width/4, y: 0)
        self.addChild(scoreBox)
        
        let froggerLogo = SKSpriteNode(texture: SKTexture(imageNamed:"froggerLogo"), color: .clear, size: CGSize(width: 200, height: 200))
        froggerLogo.position = CGPoint(x: -self.size.width/4, y: self.size.height/4)
        self.addChild(froggerLogo)
        
        playButton = ButtonNode(texture: SKTexture(imageNamed:"playSprite"), size: CGSize(width: 120, height: 60), scene: self)
        playButton.position = CGPoint(x: -self.size.width/4, y: -self.size.height/4)
        self.addChild(playButton)
        
        setScoresLabels()
        

    }
    func setScoresLabels(){
       
    
        let scoreLines = SKLabelNode(fontNamed: "Early-GameBoy")
        scoreLines.position = CGPoint(x: 0, y: scoreBox.size.height/4)
        scoreLines.text = ScoresManager.getScores(rankQnt: 5)
        scoreLines.fontSize = 10
        scoreLines.numberOfLines = 10
        scoreBox.addChild(scoreLines)
        
        
    }
    func setSelectedButton(buttonNode: ButtonNode) {
        
    }
    func setDeselectedButton(buttonNode: ButtonNode) {
        self.menuDelegate.playGame()
    }

    

}
