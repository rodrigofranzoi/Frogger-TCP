//
//  Vehicle.swift
//  Frogger
//
//  Created by Rodrigo Franzoi Scroferneker on 03/12/17.
//  Copyright © 2017 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import SpriteKit



class Vehicle: ObjectNode {
    
    let BLOCK_DISTANCE : Double = 13
    let BLOCK_SIZE : Double = 32
    
    var vSpeed : Double
    
    init(image: String, speed: Double, size: CGSize, orientation: ObjectFaceOrientation) {
        self.vSpeed = speed
        
        super.init(imageNamed: image, size: size, position: CGPoint(x: 0.0, y: 0.0), orientation: orientation)
        
        self.name = "vehicle"
        
        self.zPosition = 3
        
        let vTexture = SKTexture(imageNamed: image)
        
        self.physicsBody = SKPhysicsBody(texture: vTexture, size: vTexture.size())
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = ColliderType.Consumible
        self.physicsBody?.contactTestBitMask = ColliderType.Player
        
    }
    
    func getDirVector() -> CGVector{
        switch orientation{
        case .up:
            return CGVector(dx: 0.0, dy: BLOCK_DISTANCE * BLOCK_SIZE)
        case .down:
            return CGVector(dx: 0.0, dy: -BLOCK_DISTANCE * BLOCK_SIZE)
        case .left:
            return CGVector(dx: -BLOCK_DISTANCE * BLOCK_SIZE, dy: 0.0)
        case .right:
            return CGVector(dx: BLOCK_DISTANCE * BLOCK_SIZE, dy: 0.0)
        }
    }
    
    func startMoving() {
        self.run(SKAction.move(by: getDirVector(), duration: 100/vSpeed)) {
            self.removeFromParent()
        }
    }
    
    func startMoving(withDirection direction : ObjectFaceOrientation) {
        
        //The car will change the lane between the third block and the block BLOCK_DISTANCE-2
        let changeLaneBlock = 2.0 + Double(arc4random_uniform(UInt32(BLOCK_DISTANCE-4)))
        
        self.run(SKAction.move(by: getDirVector(), duration: 100/vSpeed)) {
            self.removeFromParent()
        }
        
        self.run(SKAction.wait(forDuration: Double(100/vSpeed) * changeLaneBlock / BLOCK_DISTANCE)) {
            self.run(SKAction.move(by: self.getChangeLaneVector(direction), duration: 1))
        }
    }
    
    func getChangeLaneVector(_ direction : ObjectFaceOrientation) -> CGVector{
        switch direction{
        case .up:
            return CGVector(dx: 0.0, dy: -1 * BLOCK_SIZE)
        case .down:
            return CGVector(dx: 0.0, dy: 1 * BLOCK_SIZE)
        case .left:
            return CGVector(dx: -1 * BLOCK_SIZE, dy: 0.0)
        case .right:
            return CGVector(dx: 1 * BLOCK_SIZE, dy: 0.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Car : Vehicle {
    
    init(size: CGSize, orientation: ObjectFaceOrientation) {
        super.init(image: "car2", speed: 30, size: size, orientation: orientation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class Bus: Vehicle {
    init(size: CGSize, orientation: ObjectFaceOrientation) {
        super.init(image: "bus", speed: 20, size: CGSize(width: 32, height: 64), orientation: orientation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Bike: Vehicle {
    init(size: CGSize, orientation: ObjectFaceOrientation) {
        super.init(image: "car1", speed: 10, size: size, orientation: orientation)
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
