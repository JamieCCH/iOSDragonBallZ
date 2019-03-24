//
//  GameViewController.swift
//  DragonBallZ
//
//  Created by Jamie on 2019/3/10.
//  Copyright © 2019 Jamie. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var dialogScene: DialogScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as! SKView
        skView.showsFPS = true
        
        skView.showsPhysics = true
        
        dialogScene = DialogScene(size: skView.bounds.size)
        dialogScene.scaleMode = .aspectFit
        
        let gamePlayScene = GameScene(size: skView.bounds.size)
        gamePlayScene.scaleMode = .aspectFit
    
        
        let gameOver = GameOverScene(size: skView.bounds.size)
        gameOver.scaleMode = .aspectFit
        
        
        skView.presentScene(gamePlayScene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
