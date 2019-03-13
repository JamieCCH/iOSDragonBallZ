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
    
    let velocityMultiplier: CGFloat = 0.12
    
    enum NodesZPosition: CGFloat{
        case background, player, gamepad
    }
    
    lazy var background:SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "budokai")
        sprite.zPosition = NodesZPosition.background.rawValue
        sprite.size = frame.size
        sprite.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        sprite.position = CGPoint(x: size.width / 2.0, y: 0.0)
        return sprite
    }()
    
    lazy var analogJoystick: AnalogJoystick = {
        let js = AnalogJoystick(diameter: 100, colors: nil, images: (substrate: #imageLiteral(resourceName: "joystickBase"), stick: #imageLiteral(resourceName: "joystick")))
        js.position = CGPoint(x: js.radius + 50, y: self.frame.size.height/5.5)
        js.zPosition = NodesZPosition.gamepad.rawValue
        return js
    }()
    
    lazy var kickButton:SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "buttonA")
        sprite.setScale(0.6)
        sprite.zPosition = NodesZPosition.gamepad.rawValue
        sprite.position = CGPoint(x: self.size.width - 110, y: self.frame.size.height/4)
        return sprite
    }()
    
    lazy var punchButton:SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "buttonB")
        sprite.setScale(0.6)
        sprite.zPosition = NodesZPosition.gamepad.rawValue
        sprite.position = CGPoint(x: self.size.width - 160, y: self.frame.size.height/7.5)
        return sprite
    }()
    
    lazy var fireButton:SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "buttonFire")
        sprite.setScale(0.6)
        sprite.zPosition = NodesZPosition.gamepad.rawValue
        sprite.position = CGPoint(x: self.size.width - 60, y: self.frame.size.height/7.5)
        return sprite
    }()
    
    
    private var GohanSprite = SKSpriteNode()
    private var GohanIdleFrames: [SKTexture] = []
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func setInitPosition(){
        GohanSprite.position = CGPoint(x: frame.midX, y: GohanSprite.frame.height/2)
    }
    
    func buildIdleAnimation() {
        let idleAtlas = SKTextureAtlas(named: "GohanIdle")
        let numImages = idleAtlas.textureNames.count - 1
        for i in 0...numImages {
            let idleTextureName = "Gohan_Idle\(i)"
            GohanIdleFrames.append(idleAtlas.textureNamed(idleTextureName))
        }
        let firstFrameTexture = GohanIdleFrames[0]
        GohanSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    override init(size: CGSize){
        super.init(size: size)
        buildIdleAnimation()
        setInitPosition()
    }
    
    func setupNodes(){
        addChild(background)
        addChild(GohanSprite)
        addChild(punchButton)
        addChild(kickButton)
        addChild(fireButton)
    }
    
//    func setAnimate(SpriteNode:SKSpriteNode, TextureName:[SKTexture], Interval:Double, CanResize: Bool, CanRestore: Bool, KeyName:String){
//        SpriteNode.run(SKAction.repeatForever(
//            SKAction.animate(with: TextureName, timePerFrame:Interval, resize: CanRestore, restore: CanRestore)),withKey:KeyName)
//    }
    
    func setupJoystick() {
        addChild(analogJoystick)
        
        analogJoystick.trackingHandler = { [unowned self] data in
            self.GohanSprite.position = CGPoint(x: self.GohanSprite.position.x + (data.velocity.x * self.velocityMultiplier),
                                                y: self.GohanSprite.position.y + (data.velocity.y * self.velocityMultiplier))
            self.GohanSprite.zRotation = data.angular
        }
    }
    
    override func didMove(to view: SKView) {
        setupNodes()
        GohanSprite.run(SKAction.repeatForever(SKAction.animate(with: GohanIdleFrames, timePerFrame:0.2, resize: true, restore: true)),withKey:"GohanIdle")
        setupJoystick()
    }
}
