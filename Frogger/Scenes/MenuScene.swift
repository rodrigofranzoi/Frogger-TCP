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
    var playButton : SKSpriteNode!
    
    override func didMove(to view: SKView) {
    
        self.playButton = SKSpriteNode(texture: nil, color: .red, size: CGSize(width: 5, height: 5))
        self.addChild(playButton)
        
    }
    
    
    func setSelectedButton(buttonNode: ButtonNode) {
        
    }
    func setDeselectedButton(buttonNode: ButtonNode) {
        self.menuDelegate.playGame()
    }

    

}
