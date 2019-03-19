//
//  GameScene.swift
//  DragonBallZ
//
//  Created by Jamie on 2019/3/10.
//  Copyright © 2019 Jamie. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    enum NodesZPosition: CGFloat{
        case background, player, controller
    }
    
    let controller = OnScreenController()
    let player = Gohan()
    
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
    }
    
    func setupController(){
        controller.setupJoystick(player: player.GohanSprite)
    }
    
    override func didMove(to view: SKView) {
        setupNodes()
        setNodesPositions()
        setupController()
        
        player.idle()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        controller.checkDirection()
        if(controller.analogJoystick.isTouched){
            if controller.stickPoint == "up"{
                player.jump()
            }
            if controller.stickPoint == "down"{
                player.squat()
            }
            if controller.stickPoint == "right"{
                player.backward()
            }
            if controller.stickPoint == "left"{
                player.forward()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
//        if let touch = touches.first, controller.analogJoystick.stick == atPoint(touch.location(in: controller.analogJoystick.stick)){
//            print("---")
//        }
    }
}
