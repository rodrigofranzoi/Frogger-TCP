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
    var gameLevel = 1
    
    private var cam:SKCameraNode!
    private var camMaxYPoint : CGFloat = 0.0
    
    private var hudLayer : HudLayer!
    private var mapManager : MapManager!
    
    public var player : PlayerNode!
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        
        self.configureGestures()

        self.mapManager = MapManager()
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

        if playerY > self.camMaxYPoint {
            self.hudLayer.setScore(1)
            self.camMaxYPoint = playerY
        }
        self.cam.position = CGPoint(x: self.CAM_WIDTH + 32, y: self.camMaxYPoint)
        
        if self.mapManager.yPosition - 100 < self.player.position.y {
            self.gameLevel += 1
            self.mapManager.loadMap(mapName: "Frogger34")
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {

        if contact.bodyA.node?.name == "player"  {
            if contact.bodyB.node?.name == "vehicle" {
                self.player.removeLife()
                self.hudLayer.setLifes(self.player.getLifes())
            } else if contact.bodyB.node?.name == "coin" {
                contact.bodyB.node?.removeFromParent()
                self.hudLayer.setScore(500)
            }
        } else if contact.bodyA.node?.name == "coin" {
            contact.bodyA.node?.removeFromParent()
            self.hudLayer.setScore(500)
        } else if contact.bodyA.node?.name == "vehicle" {
            self.player.removeLife()
            self.hudLayer.setLifes(self.player.getLifes())
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
    
    public func endGame() {
        self.gameDelegate.endGame(score: self.hudLayer.getScore())
    }
    
    public func restart() {
        self.gameDelegate.restart()
    }
}

extension GameScene : PlayerDelegate {
    func playerDidDie() {
        self.endGame()
    }
}

extension GameScene : MapDelegate {
    
    func setSize(size: CGSize) {
        self.size = CGSize(width: size.width - 64, height: size.height)
    }
    
    func nodeForMatrix(mapHeight: Int, mapWidth: Int, index: Int, objCode: Int, spriteSize: CGSize, position: CGPoint, layerName: String) {
        if objCode != 0 {
            if layerName == "frog" {
                if self.player == nil {
                    self.player = PlayerNode(imageNamed: objCode.description, size: spriteSize, position: position)
                    self.player.delegate = self
                    self.scene?.addChild(player)
                }
            } else if layerName == "ground" {
                let obj = Ground(imageNamed: objCode.description, size: spriteSize, position: position, level: self.gameLevel)
                self.scene?.addChild(obj)
            } else if layerName == "right-spawn" {
                let obj = Spawn(faceOrientation: .right, level: self.gameLevel, imgNamed: objCode.description, size: spriteSize, position: position)
                self.scene?.addChild(obj)
            } else if layerName == "left-spawn" {
                let obj = Spawn(faceOrientation: .left, level: self.gameLevel, imgNamed: objCode.description, size: spriteSize, position: position)
                self.scene?.addChild(obj)
            } else if layerName == "obstacle" {
                let obj = ObstacleNode(imageNamed: objCode.description, size: spriteSize, position: position)
                obj.setOrientation(to: .up)
                self.scene?.addChild(obj)
            } else if layerName == "left-spawn-double-up" {
                let obj = DoubleSpawn(faceOrientation: .left, level: self.gameLevel, imgNamed: objCode.description, size: spriteSize, position: position, laneDirection: .up)
                self.scene?.addChild(obj)
            }  else if layerName == "left-spawn-double-down" {
                let obj = DoubleSpawn(faceOrientation: .left, level: self.gameLevel, imgNamed: objCode.description, size: spriteSize, position: position, laneDirection: .down)
                self.scene?.addChild(obj)
            }  else if layerName == "right-spawn-double-up" {
                let obj = DoubleSpawn(faceOrientation: .right, level: self.gameLevel, imgNamed: objCode.description, size: spriteSize, position: position, laneDirection: .up)
                self.scene?.addChild(obj)
            }  else if layerName == "right-spawn-double-down" {
                let obj = DoubleSpawn(faceOrientation: .right, level: self.gameLevel, imgNamed: objCode.description, size: spriteSize, position: position, laneDirection: .down)
                self.scene?.addChild(obj)
            }
        }
    }
}
