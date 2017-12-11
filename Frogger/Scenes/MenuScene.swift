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
        
        playButton = ButtonNode(texture: SKTexture(imageNamed:"playSprite"), size: CGSize(width: 120, height: 60), scene: self)
        playButton.position = CGPoint(x: -self.size.width/4, y: 0)
        self.addChild(playButton)
        
        setScoresLabels()
        

    }
    func setScoresLabels(){
       
        let scoreLines = ScoresManager.getScores(ArraySize: 5)
        
        var spaceBetweenScores = 15
        
        //for ever score, creates a label in the scoresBox
        for score in scoreLines{
            
            let newScoreLine = SKLabelNode(fontNamed: "Early-GameBoy")
            newScoreLine.position = CGPoint(x: 0, y: scoreBox.size.height/2 - CGFloat(spaceBetweenScores))
            newScoreLine.text = score
            newScoreLine.fontSize = 10
            spaceBetweenScores += 15
            scoreBox.addChild(newScoreLine)
            
        }

        
    }
    func setSelectedButton(buttonNode: ButtonNode) {
        
    }
    func setDeselectedButton(buttonNode: ButtonNode) {
        self.menuDelegate.playGame()
    }

    

}
