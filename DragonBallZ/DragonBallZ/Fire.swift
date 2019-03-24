//
//  Fire.swift
//  DragonBallZ
//
//  Created by Jamie on 2019/3/23.
//  Copyright © 2019 Jamie. All rights reserved.
//

import Foundation
import SpriteKit

public class Fire{
    
    var fireSprite:SKSpriteNode
    var fireFrames: [SKTexture] = []
    
    public init(){
        fireSprite = SKSpriteNode()
        buildFireAnimation()
    }
    
    private func buildFireAnimation(){
        let fireAtlas = SKTextureAtlas(named: "GFire")
        let numImages = fireAtlas.textureNames.count - 1
        for i in 0...numImages {
            let fireTextureName = "fire_\(i)"
            fireFrames.append(fireAtlas.textureNamed(fireTextureName))
        }
        let firstFrameTexture = fireFrames[0]
        fireSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    func shootAni(){
//        let wait = SKAction.wait(forDuration: 0.5)
//        let shoot = SKAction.repeatForever(SKAction.animate(with: fireFrames, timePerFrame:0.25, resize: true, restore: true))
//        fireSprite.run(SKAction.sequence([wait, shoot]),withKey:"Shoot")
        fireSprite.run(SKAction.animate(with: fireFrames, timePerFrame: 0.3, resize: true, restore: false))
    }
    
}
