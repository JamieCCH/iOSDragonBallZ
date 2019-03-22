//
//  GameScene.swift
//  DragonBallZ
//
//  Created by Jamie on 2019/3/10.
//  Copyright © 2019 Jamie. All rights reserved.
//

import SpriteKit
import GameplayKit

let wallCategory: UInt32 = 0x1 << 0
let playerCategory: UInt32 = 0x1 << 1

public var winner = ""

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    enum NodesZPosition: CGFloat{
        case background, player, controller,hpBar, UI
    }
    
    let controller = OnScreenController()
    let player = Gohan()
    let UI = UIManager()
    
    lazy var background:SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "budokai")
        sprite.zPosition = NodesZPosition.background.rawValue
        sprite.size = frame.size
        sprite.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        sprite.position = CGPoint(x: size.width / 2.0, y: 0.0)
        return sprite
    }()
    
    override init(size: CGSize){
        super.init(size: size)}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNodes(){
        addChild(background)
        addChild(player.GohanSprite)
        addChild(controller.punchButton)
        addChild(controller.kickButton)
        addChild(controller.fireButton)
        addChild(controller.analogJoystick)
        addChild(UI.timerLabel)
        addChild(UI.enemyMugshot)
        addChild(UI.playerMugshot)
        addChild(UI.playerHpBar)
        addChild(UI.enemyHpBar)
    }
    
    func setPhysics(){
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        self.physicsWorld.contactDelegate = self
        
        let wallRect = CGRect(x: 0, y: 50, width: self.frame.size.width, height: self.frame.size.height)
        let borderBody = SKPhysicsBody(edgeLoopFrom: wallRect)
        self.physicsBody =  borderBody
        
        player.GohanSprite.physicsBody = SKPhysicsBody(texture: (player.GohanSprite.texture)!, size: (player.GohanSprite.size))
        player.GohanSprite.physicsBody?.affectedByGravity = true
        player.GohanSprite.physicsBody?.mass = 2.0
        player.GohanSprite.physicsBody?.allowsRotation = false
    }
    
    func setNodesPositions(){
        controller.analogJoystick.zPosition = NodesZPosition.controller.rawValue
        controller.kickButton.zPosition = NodesZPosition.controller.rawValue
        controller.punchButton.zPosition = NodesZPosition.controller.rawValue
        controller.fireButton.zPosition = NodesZPosition.controller.rawValue
        controller.analogJoystick.position = CGPoint(x: controller.analogJoystick.radius + 50, y: frame.size.height/5.5)
        controller.kickButton.position = CGPoint(x: self.size.width - 110, y: self.frame.size.height/4)
        controller.punchButton.position = CGPoint(x: self.size.width - 160, y: self.frame.size.height/7.5)
        controller.fireButton.position = CGPoint(x: self.size.width - 60, y: self.frame.size.height/7.5)
        
        player.GohanSprite.position = CGPoint(x: frame.midX, y: player.GohanSprite.size.height)
        player.GohanSprite.zPosition = NodesZPosition.player.rawValue
        player.GohanSprite.setScale(1.2)
        
        UI.timerLabel.position = CGPoint(x: frame.midX, y: frame.maxY - UI.timerLabel.frame.size.height*1.5)
        UI.enemyMugshot.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        UI.enemyMugshot.position = CGPoint(x: 0.0, y: frame.maxY)
        UI.enemyMugshot.zPosition = NodesZPosition.UI.rawValue
        UI.playerMugshot.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        UI.playerMugshot.position = CGPoint(x: frame.maxX, y: frame.maxY)
        UI.playerMugshot.zPosition = NodesZPosition.UI.rawValue
        
        UI.playerHpBar.position = CGPoint(x: frame.maxX - UI.playerMugshot.size.width,
                                          y: frame.maxY - UI.playerMugshot.frame.size.height/2 + UI.playerHpBar.size.height/2)
        UI.playerHpBar.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        UI.playerHpBar.zPosition = NodesZPosition.hpBar.rawValue
        
        UI.enemyHpBar.position = CGPoint(x: UI.enemyMugshot.size.width,
                                         y: frame.maxY - UI.enemyMugshot.frame.size.height/2 + UI.enemyHpBar.size.height/2)
        UI.enemyHpBar.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        UI.enemyHpBar.zPosition = NodesZPosition.hpBar.rawValue
        
    }
    
//    func setupController(){
//        controller.setupJoystick(player: player.GohanSprite)
//    }
    
    override func didMove(to view: SKView) {
        setupNodes()
        setNodesPositions()
//        setupController()
        setPhysics()
        player.idle()
        
        UI.counter = UI.counterStartVal
        UI.startCounter()
    }
    
    func setDamage(name:SKSpriteNode,damage:CGFloat){
//        UI.playerHpBar.run(SKAction.resize(byWidth: -1.5, height: 0.0, duration: 0.1))
//        UI.enemyHpBar.run(SKAction.resize(byWidth: -1.5, height: 0.0, duration: 0.1))
        name.run(SKAction.resize(byWidth: -damage, height: 0.0, duration: 0.1))
    }
    
    public func getWinner() -> SKSpriteNode{
        var winner = SKSpriteNode()
        if(UI.playerHpBar.size.width < UI.playerHpBar.size.width){
            winner = UI.playerMugshot
            UI.isGameOver = true
        }else{
            winner = UI.enemyMugshot
            UI.isGameOver = true
        }
        
        return winner
    }
    
    func loadGameOverScene(){
        let transition = SKTransition.fade(withDuration: 2.0)
        let nextScene = GameOverScene(size: self.frame.size)
        view?.presentScene(nextScene, transition: transition)
    }
    
    override func update(_ currentTime: TimeInterval) {
        controller.checkDirection()
        
        //player control setup
        if(controller.analogJoystick.isTouched){
            if controller.stickPoint == "up"{
                player.jump()
                player.GohanSprite.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 250))
            }
            if controller.stickPoint == "down"{
                player.squat()
            }
            if controller.stickPoint == "right"{
                player.backward()
                player.GohanSprite.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 10))
            }
            if controller.stickPoint == "left"{
                player.forward()
                 player.GohanSprite.physicsBody?.applyImpulse(CGVector(dx: -100, dy: 10))
            }
        }
        
        //check game over
        if UI.playerHpBar.size.width <= 0 || UI.enemyHpBar.size.width <= 0{
            UI.isGameOver = true
        }
        
        
        //check winner
        if UI.playerHpBar.size.width < UI.enemyHpBar.size.width{
            winner = "Piccolo"
        }else{
            winner = "Gohan"
        }
        
        if(UI.isGameOver == true)
        {
            loadGameOverScene()
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //for debug
        setDamage(name: UI.playerHpBar,damage: 26.0)
        print("player: \(UI.playerHpBar.size.width)")
        print("enemy: \(UI.enemyHpBar.size.width)")
        
        for t in touches {
            let location = t.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "FireButton" {
                print("FireButton")
                player.fire()
            }
            if touchedNode.name == "PunchButton" {
                print("PunchButton")
                player.melee()
            }
            if touchedNode.name == "KickButton" {
                print("PunchButton")
                player.kick()
            }
        }

    }
}
