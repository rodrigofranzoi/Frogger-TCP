//
//  Coin.swift
//  Frogger
//
//  Created by Rodrigo Franzoi Scroferneker on 09/12/17.
//  Copyright © 2017 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import SpriteKit

class Coin: ObjectNode {
    
    init(image: String, size: CGSize) {
        
        super.init(imageNamed: image, size: size, position: CGPoint(x: 0.0, y: 0.0))
        
        self.name = "coin"
        
        self.zPosition = 2.5
        self.color = .red
        
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = ColliderType.Consumible
        self.physicsBody?.contactTestBitMask = ColliderType.Player
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
