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
    
    let NUMB_RANK = 10
    
    var menuDelegate : MenuDelegate!
    var playButton : ButtonNode!
    var scoreBox : SKSpriteNode!
    
    var mapManager : MapManager!
    
    var map : SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        self.scaleMode = .aspectFill
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.size = CGSize(width: 12 * 32, height: 10 * 32)
    
        self.setTitle()
        self.mapSettings()
        self.setPlayButton()
        self.setScoresLabels()
    }
    
    func setPlayButton() {
        self.playButton = ButtonNode(texture: SKTexture(imageNamed:"play-button"), size: CGSize(width: 100, height: 50), scene: self)
        self.playButton.position = CGPoint(x: -self.size.width/4 - 15, y: 10)
        self.playButton.zPosition = 21
        self.addChild(playButton)
    }
    
    func mapSettings() {
        
        self.map = SKSpriteNode(texture: nil, color: .clear, size: CGSize(width: 12 * 32, height: 10 * 32))
        self.map.zPosition = 0
        self.map.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.map.position = CGPoint(x: 0.0, y: 0.0)
        
        self.mapManager = MapManager()
        self.mapManager.delegate = self
        self.mapManager.loadMap(mapName: "MenuMap")
        
        self.addChild(self.map)
    }
    
    func setScoresLabels(){

        self.scoreBox = SKSpriteNode(texture: nil, color: .green, size: CGSize(width: self.size.width/2 + 20, height:  self.size.height - 60))
        self.scoreBox.position = CGPoint(x: self.size.width/4 - 20, y: 0)
        self.scoreBox.zPosition = 20
        //self.scoreBox.alpha = 0.8
        
        self.addChild(scoreBox)
        
        let scoreLines = SKLabelNode(fontNamed: "Early-GameBoy")
        scoreLines.position = CGPoint(x: 0, y: -scoreBox.size.height/4)
        scoreLines.text = ScoresManager.getScores(rankQnt: NUMB_RANK)
        scoreLines.fontSize = 8
        scoreLines.numberOfLines = NUMB_RANK
        scoreLines.zPosition = 22
        scoreBox.addChild(scoreLines)
        
        let shadow = SKLabelNode(fontNamed: "Early-GameBoy")
        shadow.position = CGPoint(x: 1, y: -scoreBox.size.height/4 - 1)
        shadow.text = ScoresManager.getScores(rankQnt: NUMB_RANK)
        shadow.fontColor = .black
        shadow.fontSize = 8
        shadow.numberOfLines = NUMB_RANK
        shadow.zPosition = 21
        scoreBox.addChild(shadow)
    }
    
    func setLastScoreLabel(score: Int) {
        
        let node = SKLabelNode(fontNamed: "Early-GameBoy")
        node.position = CGPoint(x: -self.size.width/4, y: -self.size.height/4)
        node.text = "Score:\n" + score.description
        node.fontSize = 20
        node.numberOfLines = 2
        node.zPosition = 26
        self.addChild(node)
        
        let shadow = SKLabelNode(fontNamed: "Early-GameBoy")
        shadow.position = CGPoint(x: -self.size.width/4 + 2, y: -self.size.height/4 - 2)
        shadow.text = "Score:\n" + score.description
        shadow.fontColor = .black
        shadow.fontSize = 20
        shadow.numberOfLines = 2
        shadow.zPosition = 25
        self.addChild(shadow)
        
    }
    
    func setTitle() {
        let title = SKLabelNode(fontNamed: "Early-GameBoy")
        title.position = CGPoint(x: -self.size.width/4 - 10, y: self.size.height/4 - 30)
        title.text = "Frogger"
        title.fontSize = 20
        title.numberOfLines = 2
        title.zPosition = 26
        self.addChild(title)
        
        let shadow = SKLabelNode(fontNamed: "Early-GameBoy")
        shadow.position = CGPoint(x: -self.size.width/4 - 8, y: self.size.height/4 - 32)
        shadow.text = "Frogger"
        shadow.fontColor = .black
        shadow.fontSize = 20
        shadow.numberOfLines = 2
        shadow.zPosition = 25
        self.addChild(shadow)
    }
    
    func setSelectedButton(buttonNode: ButtonNode) {
        
    }
    func setDeselectedButton(buttonNode: ButtonNode) {
        self.menuDelegate.playGame()
    }
}

extension MenuScene: MapDelegate {
    func setSize(size: CGSize) {
        self.size = CGSize(width: 12 * 32, height: 10 * 32)
    }
    
    func nodeForMatrix(mapHeight: Int, mapWidth: Int, index: Int, objCode: Int, spriteSize: CGSize, position: CGPoint, layerName: String) -> SKSpriteNode? {
        if objCode != 0 {
            var obj : SKSpriteNode = SKSpriteNode()
            if layerName == "ground" {
                obj = Ground(imageNamed: objCode.description, size: spriteSize, position: CGPoint(x: position.x - 16 - self.map.size.width/2, y: position.y - self.map.size.height/2), level: 1)
            } else if layerName == "right-spawn" {
                obj = Spawn(faceOrientation: .right, level: 1, imgNamed: objCode.description, size: spriteSize, position: CGPoint(x: position.x - 16 - self.map.size.width/2, y: position.y - self.map.size.height/2))
            } else if layerName == "left-spawn" {
                obj = Spawn(faceOrientation: .left, level: 1, imgNamed: objCode.description, size: spriteSize, position: CGPoint(x: position.x - 16 - self.map.size.width/2, y: position.y - self.map.size.height/2))
            } else if layerName == "obstacle" {
                obj = ObstacleNode(imageNamed: objCode.description, size: spriteSize, position: CGPoint(x: position.x - 16 - self.map.size.width/2, y: position.y - self.map.size.height/2))
            } else if layerName == "left-spawn-double-up" {
                obj = DoubleSpawn(faceOrientation: .left, level: 1, imgNamed: objCode.description, size: spriteSize, position: CGPoint(x: position.x - 16 - self.map.size.width/2, y: position.y - self.map.size.height/2), laneDirection: .up)
            }  else if layerName == "left-spawn-double-down" {
                obj = DoubleSpawn(faceOrientation: .left, level: 1, imgNamed: objCode.description, size: spriteSize, position: CGPoint(x: position.x - 16 - self.map.size.width/2, y: position.y - self.map.size.height/2), laneDirection: .down)
            }  else if layerName == "right-spawn-double-up" {
                obj = DoubleSpawn(faceOrientation: .right, level: 1, imgNamed: objCode.description, size: spriteSize, position: CGPoint(x: position.x - 16 - self.map.size.width/2, y: position.y - self.map.size.height/2), laneDirection: .up)
            }  else if layerName == "right-spawn-double-down" {
                obj = DoubleSpawn(faceOrientation: .right, level: 1, imgNamed: objCode.description, size: spriteSize, position: CGPoint(x: position.x - 16 - self.map.size.width/2, y: position.y - self.map.size.height/2), laneDirection: .down)
            }
            self.map.addChild(obj)
        }
        return nil
    }
    
}
