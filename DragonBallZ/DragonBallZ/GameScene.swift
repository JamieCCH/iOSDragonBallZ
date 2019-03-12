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
    
    private let background = SKSpriteNode(imageNamed: "budokai")
    
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
        
        background.size = frame.size
        background.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        background.position = CGPoint(x: size.width / 2.0, y: 0.0)
        addChild(background)
        
        buildIdleAnimation()
        setInitPosition()
    }
    
    
    func setAnimate(SpriteNode:SKSpriteNode, TextureName:[SKTexture], Interval:Double, CanResize: Bool, CanRestore: Bool, KeyName:String){
        SpriteNode.run(SKAction.repeatForever(
            SKAction.animate(with: TextureName, timePerFrame:Interval, resize: CanRestore, restore: CanRestore)),withKey:KeyName)
    }
    
    override func didMove(to view: SKView) {
        addChild(GohanSprite)
//        setAnimate(SpriteNode:GohanSprite,TextureName:GohanIdleFrames,Interval:0.2,CanResize:true,CanRestore:true,KeyName: "GohanIdle")
        GohanSprite.run(SKAction.repeatForever(SKAction.animate(with: GohanIdleFrames, timePerFrame:0.2, resize: true, restore: true)),withKey:"GohanIdle")
    }
}
