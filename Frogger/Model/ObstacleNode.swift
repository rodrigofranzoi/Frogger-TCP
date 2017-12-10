//
//  ObstacleNode.swift
//  Frogger
//
//  Created by Rodrigo Franzoi Scroferneker on 19/10/17.
//  Copyright © 2017 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import SpriteKit

class ObstacleNode: ObjectNode {
    
    
    override init(imageNamed image: String?, size : CGSize, position: CGPoint, orientation: ObjectFaceOrientation = .left) {
        var imageName : String?

        if image != "6" {
            imageName = image
        }
        super.init(imageNamed: imageName, size: size, position: position, orientation: orientation)
        
        self.name = "obstacle"
        
        self.zPosition = 2
        
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = ColliderType.Obstacle
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
