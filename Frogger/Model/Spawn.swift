//
//  Spawn.swift
//  Frogger
//
//  Created by Rodrigo Franzoi Scroferneker on 03/12/17.
//  Copyright © 2017 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import SpriteKit

class Spawn: ObjectNode {
    
    let MIN_VALUE = 3
    
    var carNumber : Int
    var objPosition : ObjectFaceOrientation
    
    init(faceOrientation: ObjectFaceOrientation, level: Int, imgNamed: String, size: CGSize, position: CGPoint) {
        self.carNumber = Int(arc4random_uniform(3))
        self.objPosition = faceOrientation
        
        super.init(imageNamed: imgNamed, size: size, position: position)
        //self.setOrientation(to: faceOrientation)
        self.spawnCars()
    }
    
    func spawnCars() {
        
        let diceRoll : Double = Double(30 + Int(arc4random_uniform(10)) + Int(arc4random_uniform(15)) + Int(arc4random_uniform(20)))
        
        let action = SKAction.wait(forDuration: diceRoll/10)
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
        
        vehicle.startMoving()
        addChild(vehicle)
        
        run(action) {
            self.spawnCars()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
