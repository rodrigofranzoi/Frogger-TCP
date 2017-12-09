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
        self.color = .red
        
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Car : Vehicle {
    
    init(size: CGSize, orientation: ObjectFaceOrientation) {
        //IMPLEMENTAR
        super.init(image: "", speed: 30, size: size, orientation: orientation)
        self.texture = nil
        self.color = .yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class Bus: Vehicle {
    init(size: CGSize, orientation: ObjectFaceOrientation) {
        //IMPLEMENTAR
        super.init(image: "", speed: 20, size: size, orientation: orientation)
        self.texture = nil
        self.color = .purple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Bike: Vehicle {
    init(size: CGSize, orientation: ObjectFaceOrientation) {
        //IMPLEMENTAR
        super.init(image: "", speed: 10, size: size, orientation: orientation)
        self.texture = nil
        self.color = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
