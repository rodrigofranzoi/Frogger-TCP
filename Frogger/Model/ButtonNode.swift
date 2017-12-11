//
//  PlayerNode.swift
//  Frogger
//
//  Created by Lúcio Pereira Franco on 05/12/2017.
//  Copyright © 2017 Rodrigo Franzoi Scroferneker. All rights reserved.
//


import SpriteKit

protocol ButtonDelegate {
    func setSelectedButton(buttonNode: ButtonNode)
    func setDeselectedButton(buttonNode: ButtonNode)
}

class ButtonNode: SKSpriteNode {
    
    private var selected : Bool
    private var delegate : ButtonDelegate!
    
    init(texture: SKTexture?, size: CGSize, scene:ButtonDelegate) {
        self.selected = false
        self.delegate = scene
        super.init(texture: texture, color: .cyan, size: size)
        self.isUserInteractionEnabled = true
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    func selectButton() {
        self.selected = !self.selected
        if selected {
            self.select()
        } else {
            self.deselect()
        }
    }
    
    private func select() {
        self.selected = true
        self.color = .yellow
        self.delegate.setSelectedButton(buttonNode: self)
        
        let action = SKAction.scale(to: 0.90, duration: 0.1)
        run(action)
        
    }
    
    public func deselect() {
        self.selected = false
        self.color = .cyan
        self.delegate.setDeselectedButton(buttonNode: self)
        
        let action = SKAction.scale(to: 1, duration: 0.1)
        run(action)
    }
    
    public func isSelected() -> Bool {
        return selected
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.select()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.deselect()
    }
}
