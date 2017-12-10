//
//  PlayerNode.swift
//  Frogger
//
//  Created by Rodrigo Franzoi Scroferneker on 19/10/17.
//  Copyright © 2017 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import SpriteKit

protocol PlayerDelegate {
    func playerDidDie()
}

class PlayerNode: ObjectNode {
    
    private var lifes: Int
    private var isAlive: Bool
    private var textureNode : SKSpriteNode
    private var jumpingFrames : [SKTexture]
    private var isInvulnerable : Bool
    
    public var delegate : PlayerDelegate!
    
    init(imageNamed image: String, size : CGSize, position: CGPoint) {
        //Player custom atributes
        
        self.lifes = 3
        self.isAlive = true
        self.isInvulnerable = false
        
        let spriteAtlas = SKTextureAtlas(named: "frog-animation")
        var textures = [SKTexture]()
        
        let numImages = spriteAtlas.textureNames.count
        
        for index in 0...numImages-1 {
            textures.append(spriteAtlas.textureNamed("sprite_\(index)"))
        }
        
        self.jumpingFrames = textures
        self.textureNode = ObjectNode(imageNamed: image, size: size)
        
        //Super init from ObjectNode
        super.init(imageNamed: nil, size: size, position: position)
        
        //Player node atributes
        self.name = "player"
        self.zPosition = 3
        self.color = .clear
        
        self.setPhysics()
        
        self.addChild(self.textureNode)
    }
    
    public func addLife(numberOfLifes: Int = 1) {
        self.lifes += numberOfLifes
    }
    
    public func removeLife(numberOfLifes: Int = 1) {
        if !isInvulnerable {
            
            self.lifes -= numberOfLifes
            self.blink(times: 2)
            
            if self.lifes <= 0 {
                self.die()
            } else {
                self.becomeInvulnerable(for: 1.8)
            }
        }
    }
    
    public func jump(to orientation: ObjectFaceOrientation) {
        switch orientation {
        case .up:
            let action = SKAction.move(by: CGVector(dx: 0, dy: 32), duration: 0.2)
            self.run(action)
        case .down:
            let action = SKAction.move(by: CGVector(dx: 0, dy: -32), duration: 0.2)
            self.run(action)
        case .left:
            let action = SKAction.move(by: CGVector(dx: -32, dy: 0), duration: 0.2)
            self.run(action)
        case .right:
            let action = SKAction.move(by: CGVector(dx: 32, dy: 0), duration: 0.2)
            self.run(action)
        }
        
        self.setOrientation(to: orientation)
        
        let animation = SKAction.animate(with: self.jumpingFrames, timePerFrame: 0.2/7, resize: false, restore: false)
        self.textureNode.run(animation)

        
        let zoomInAction = SKAction.scale(to: 1.2, duration: 0.1)
        self.textureNode.run(zoomInAction, completion: {
            let zoomout = SKAction.scale(to: 1, duration: 0.1)
            self.textureNode.run(zoomout)
        })
    }
    
    public func revive(numberOfLifes: Int = 3) {
        self.lifes   = numberOfLifes
        self.isAlive = true
    }
    
    private func die() {
        self.isAlive = false
        self.delegate.playerDidDie()
    }
    
    private func blink(times: Int) {
        if 0 <= times {
            let fade = SKAction.fadeAlpha(to: 0.4, duration: 0.3)
            let backFade = SKAction.fadeAlpha(to: 1, duration: 0.3)
            self.run(fade) {
                self.run(backFade, completion: {
                    self.blink(times: times - 1)
                })
            }
        }
    }
    
    public func becomeInvulnerable(for time: Double) {
        self.isInvulnerable = true
        self.run(SKAction.wait(forDuration: time)) {
            self.isInvulnerable = false
        }
    }
    
    public func getLifes() -> Int{
        return lifes
    }
    
    private func setPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width - 0.1, height: size.height - 0.1))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.contactTestBitMask = ColliderType.Consumible
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.Obstacle
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.lifes = 3
        self.isAlive = true
        self.jumpingFrames = [SKTexture]()
        self.textureNode = SKSpriteNode(texture: nil)
        self.isInvulnerable = false
        super.init(coder: aDecoder)
    }
}


