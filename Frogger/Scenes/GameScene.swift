//
//  GameScene.swift
//  Frogger
//
//  Created by Rodrigo Franzoi Scroferneker on 18/10/17.
//  Copyright © 2017 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameDelegate {
    func endGame(score: Int)
    func restart()
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let CAM_WIDTH : CGFloat = 176.0
    
    var gameDelegate: GameDelegate!
    
    var cam:SKCameraNode!
    var camMaxPoint : CGFloat = 0.0
    
    var mapManager : MapManager!
    var player : PlayerNode!
    var hudLayer : HudLayer!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        
        self.configureGestures()

        self.mapManager = MapManager(mapName: "Frogger")
        self.mapManager.delegate = self
        self.mapManager.loadMap()
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        
        self.cam = SKCameraNode()
        self.cam.position =  player.position
        
        self.hudLayer = HudLayer(screenSize: view.bounds.size)
        self.hudLayer.setScale(0.6)
        self.cam.addChild(hudLayer)
        
        self.camera = cam
        self.addChild(cam)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        let playerY = self.player.position.y

        if playerY > self.camMaxPoint {
            self.hudLayer.setScore(0)
            self.camMaxPoint = playerY
        }
        
        self.cam.position = CGPoint(x: CAM_WIDTH, y: camMaxPoint)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {

        if contact.bodyA.node?.name == "player"  {
            if contact.bodyB.node?.name == "vehicle" {
                self.player.removeLife()
                self.hudLayer.setLifes(-1)
            } else if contact.bodyB.node?.name == "coin" {
                contact.bodyB.node?.removeFromParent()
            }
        } else if contact.bodyA.node?.name == "coin" {
            contact.bodyA.node?.removeFromParent()
            self.hudLayer.setScore(500)
        } else if contact.bodyA.node?.name == "veihcle" {
            self.player.removeLife()
            self.hudLayer.setLifes(-1)
        }
    }
    
    // MARK - Gestures Configuration
    
    private func configureGestures() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp(_:)))
        swipeUp.direction = .up
        self.view?.addGestureRecognizer(swipeUp)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight(_:)))
        swipeRight.direction = .right
        self.view?.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown(_:)))
        swipeDown.direction = .down
        self.view?.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft(_:)))
        swipeLeft.direction = .left
        self.view?.addGestureRecognizer(swipeLeft)
    }
    
    @objc func swipedLeft(_ sender: UISwipeGestureRecognizer){
        self.player.jump(to: .left)
    }
    
    @objc func swipedUp(_ sender: UISwipeGestureRecognizer){
        self.player.jump(to: .up)
    }
    
    @objc func swipedRight(_ sender: UISwipeGestureRecognizer){
        self.player.jump(to: .right)
    }
    
    @objc func swipedDown(_ sender: UISwipeGestureRecognizer){
        self.player.jump(to: .down)
    }
    
    private func endGame() {
        self.gameDelegate.endGame(score: self.hudLayer.getScore())
    }
    
    private func restart() {
        
    }
    
}

extension GameScene : PlayerDelegate {
    func playerDidDie() {
        self.endGame()
    }
}

extension GameScene : MapDelegate {
    
    func setSize(size: CGSize) {
        self.size = size
    }
    
    func nodeForMatrix(mapHeight: Int, mapWidth: Int, index: Int, objCode: Int, spriteSize: CGSize, position: CGPoint, layerName: String) {
        if objCode != 0 {
            
            if layerName == "frog" {
                player = PlayerNode(imageNamed: objCode.description, size: spriteSize, position: position)
                player.delegate = self
                self.scene?.addChild(player)
            } else if layerName == "ground" {
                let obj = Ground(imageNamed: objCode.description, size: spriteSize, position: position, level: 1)
                self.scene?.addChild(obj)
            } else if layerName == "right-spawn" {
                let obj = Spawn(faceOrientation: .left, level: 1, imgNamed: objCode.description, size: spriteSize, position: position)
                self.scene?.addChild(obj)
            } else if layerName == "left-spawn" {
                let obj = Spawn(faceOrientation: .right, level: 1, imgNamed: objCode.description, size: spriteSize, position: position)
                self.scene?.addChild(obj)
            } else if layerName == "obstacle" {
                let obj = ObstacleNode(imageNamed: objCode.description, size: spriteSize, position: position)
                obj.setOrientation(to: .up)
                self.scene?.addChild(obj)
            }
        }
    }
}
