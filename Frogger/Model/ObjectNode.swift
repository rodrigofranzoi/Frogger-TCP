//
//  ObjectNode.swift
//  Frogger
//
//  Created by Rodrigo Franzoi Scroferneker on 19/10/17.
//  Copyright © 2017 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static var Player     : UInt32 = 1
    static var Obstacle   : UInt32 = 2
    static var Consumible : UInt32 = 4
}

class ObjectNode: SKSpriteNode {

    var orientation : ObjectFaceOrientation
    
    init(imageNamed image: String?, size : CGSize, position: CGPoint = CGPoint(x: 0, y: 0), orientation : ObjectFaceOrientation = .up) {
        
        self.orientation = orientation
        var texture : SKTexture?
        
        if let image = image {
            texture = SKTexture(imageNamed: image)
        }
        
        super.init(texture: texture, color: .clear, size: size)
        
        self.name = "object"
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position    = position
        
        self.zPosition = 1
        self.zRotation = CGFloat(self.orientation.rawValue).degreesToRadians()
    }
    
    public func setOrientation(to newOrientation:ObjectFaceOrientation) {
        if self.orientation != newOrientation {
            self.zRotation = CGFloat(newOrientation.rawValue).degreesToRadians()
            self.orientation = newOrientation
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
