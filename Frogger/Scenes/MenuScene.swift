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
    
    
    override func didMove(to view: SKView) {
    
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        playButton = ButtonNode(texture: SKTexture(imageNamed:"playSprite"), size: CGSize(width: 100, height: 40), scene: self)
        self.addChild(playButton)
        
        setRecordsLabels()
        
        let str : String = ScoresManager.getScores(rankQnt: 5)
        print(str)
    }
    func setRecordsLabels(){
        
            
    }
    func setSelectedButton(buttonNode: ButtonNode) {
        
    }
    func setDeselectedButton(buttonNode: ButtonNode) {
        self.menuDelegate.playGame()
    }

    

}
