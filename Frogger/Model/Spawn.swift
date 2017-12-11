//
//  Spawn.swift
//  Frogger
//
//  Created by Rodrigo Franzoi Scroferneker on 03/12/17.
//  Copyright © 2017 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import SpriteKit

class Spawn: ObjectNode {

    var carNumber : Int
    var objPosition : ObjectFaceOrientation
    var level : Int
    
    init(faceOrientation: ObjectFaceOrientation, level: Int, imgNamed: String, size: CGSize, position: CGPoint) {
        self.carNumber = Int(arc4random_uniform(3))
        self.objPosition = faceOrientation
        self.level = level
        super.init(imageNamed: nil, size: size, position: position)
        self.spawnCars()
    }
    
    func spawnCars() {
        
        let action = SKAction.wait(forDuration: self.getCarsInterval())
        var vehicle : Vehicle!
        
        switch self.carNumber {
        case 0:
            vehicle = Car(size: size, orientation: objPosition)
        case 1:
            vehicle = Bike(size: size, orientation: objPosition)
        case 2:
            vehicle = Bus(size: size, orientation: objPosition)
        default:
            vehicle = Car(size: size, orientation: objPosition)
        }
        
        self.move(vehicle: vehicle)
        addChild(vehicle)
        run(action) {
            self.spawnCars()
        }
    }
    
    public func move(vehicle : Vehicle) {
        vehicle.startMoving()
    }
    
    public func getCarsInterval() -> Double {
        let diceRoll : Double = Double(30 + Int(arc4random_uniform(10)) + Int(arc4random_uniform(15)) + Int(arc4random_uniform(20)))
        
        return  diceRoll/20 * Double(5/self.level)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DoubleSpawn : Spawn {
    
    var laneDirection : ObjectFaceOrientation
    
    init(faceOrientation: ObjectFaceOrientation, level: Int, imgNamed: String, size: CGSize, position: CGPoint, laneDirection: ObjectFaceOrientation ) {
        self.laneDirection = laneDirection
        super.init(faceOrientation: faceOrientation, level: level, imgNamed: imgNamed, size: size, position: position)
    }
    
    override func move(vehicle: Vehicle) {
        vehicle.startMoving(withDirection: laneDirection)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
