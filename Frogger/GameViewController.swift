//
//  GameViewController.swift
//  Frogger
//
//  Created by Rodrigo Franzoi Scroferneker on 18/10/17.
//  Copyright © 2017 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            self.loadMenu(view, score: nil)
        }
    }
    
    private func loadGame(_ view: SKView) {
        let scene = GameScene()
        scene.gameDelegate = self
        view.presentScene(scene)
    }
    
    private func debug(_ view: SKView) {
        view.ignoresSiblingOrder = true
        view.showsPhysics = true
        view.showsFPS = true
        view.showsNodeCount = true
    }
    
    private func loadMenu(_ view: SKView, score: Int?) {
        let menu = MenuScene()
        menu.menuDelegate = self
        view.presentScene(menu)
        if let score = score {
            menu.setLastScoreLabel(score: score)
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController : MenuDelegate {
    func playGame() {
        if let view = self.view as! SKView? {
            self.loadGame(view)
        }
    }
}

extension GameViewController : GameDelegate {
    func endGame(score: Int) {
        if let view = self.view as! SKView? {
            self.loadMenu(view, score: score)
            self.debug(view)
        }
    }
    
    func restart() {
        if let view = self.view as! SKView? {
            self.loadGame(view)
            self.debug(view)
        }
    }
    
    
}
