//
//  GameOverScene.swift
//  DragonBallZ
//
//  Created by Jamie on 2019/3/19.
//  Copyright © 2019 Jamie. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    lazy var gameOver:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        label.text = "Game Over"
        label.fontColor = UIColor.yellow
        label.horizontalAlignmentMode = .center
        label.position = CGPoint(x: frame.midX, y: frame.maxY - 60)
        label.fontSize = 50
        return label
    }()
    
    lazy var winnerTitle:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "MarkerFelt-Thin")
        label.text = "Winner:"
        label.fontColor = UIColor.white
        label.horizontalAlignmentMode = .left
        label.position = CGPoint(x: frame.size.width/2 - label.frame.width, y: gameOver.position.y - 100)
        return label
    }()
    
    lazy var restartButton:SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "button_play_again")
        sprite.name = "RestartButton"
        sprite.setScale(0.3)
        sprite.position = CGPoint(x: frame.midX, y: self.frame.size.height/4)
        return sprite
    }()
    
    func showWinner(winnerName:String){
        let winnerMugshot = SKSpriteNode(imageNamed: "\(winnerName)Mugshot")
        winnerMugshot.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        winnerMugshot.setScale(0.5)
        winnerMugshot.position.x = winnerTitle.position.x + winnerTitle.frame.size.width + 10
        winnerMugshot.position.y = winnerTitle.position.y
        addChild(winnerMugshot)
    }
    
    func addGameOverBGM()
    {
        let BGM = SKAudioNode(fileNamed: "gameOver.mp3")
        addChild(BGM)
        BGM.run(SKAction.play())
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        addChild(gameOver)
        addChild(winnerTitle)
        addChild(restartButton)
        addGameOverBGM()
        showWinner(winnerName: winner)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadDialogScene(){
        let transition = SKTransition.fade(withDuration: 2.0)
        let nextScene = DialogScene(size: self.frame.size)
        view?.presentScene(nextScene, transition: transition)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "RestartButton" {
                loadDialogScene()
            }
        }
    }
}
