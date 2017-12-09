//
//  Ground.swift
//  Frogger
//
//  Created by Rodrigo Franzoi Scroferneker on 09/12/17.
//  Copyright © 2017 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import SpriteKit

class Ground: ObjectNode {
    
    var level : Int
    var shouldSpawnCoins : Bool
    
    init(imageNamed image: String?, size: CGSize, position: CGPoint, orientation: ObjectFaceOrientation = .up, level: Int, shouldSpawnCoins : Bool = true) {
        self.level = level
        self.shouldSpawnCoins = shouldSpawnCoins
        
        super.init(imageNamed: image, size: size, position: position, orientation: orientation)
        
        if shouldSpawnCoins {
            let diceRoll = Int(arc4random_uniform(15))
            if diceRoll == 0 {
                let coin = Coin(image: "coin", size: size)
                self.addChild(coin)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
