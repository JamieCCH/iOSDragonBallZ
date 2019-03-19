//
//  Character.swift
//  DragonBallZ
//
//  Created by Jamie on 2019/3/12.
//  Copyright © 2019 Jamie. All rights reserved.
//

import Foundation
import SpriteKit

public class Gohan {
    
    var GohanSprite:SKSpriteNode
    private var GohanIdleFrames: [SKTexture] = []
    private var GohanFireFrames: [SKTexture] = []
    private var GohanMeleeFrames: [SKTexture] = []
    private var GohanKickFrames: [SKTexture] = []
    private var GohanJumpFrames: [SKTexture] = []
    private var GohanSquatFrames: [SKTexture] = []
    private var GohanForwardFrames: [SKTexture] = []
    private var GohanBackwardFrames: [SKTexture] = []
    
    public init(){
        GohanSprite = SKSpriteNode()
        buildIdleAnimation()
        buildFireAnimation()
        buildMileeAnimation()
        buildKickAnimation()
        buildJumpAnimation()
        buildSquatAnimation()
        buildForwardAnimation()
        buildBackwardAnimation()
    }
    
    private func buildIdleAnimation() {
        let idleAtlas = SKTextureAtlas(named: "GohanIdle")
        let numImages = idleAtlas.textureNames.count - 1
        for i in 0...numImages {
            let idleTextureName = "Gohan_Idle\(i)"
            GohanIdleFrames.append(idleAtlas.textureNamed(idleTextureName))
        }
        let firstFrameTexture = GohanIdleFrames[0]
        GohanSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildFireAnimation() {
        let fireAtlas = SKTextureAtlas(named: "GohanFire")
        let numImages = fireAtlas.textureNames.count - 1
        for i in 0...numImages {
            let fireTextureName = "Gohan_Fire\(i)"
            GohanFireFrames.append(fireAtlas.textureNamed(fireTextureName))
        }
        let firstFrameTexture = GohanFireFrames[0]
        GohanSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildMileeAnimation() {
        let meleeAtlas = SKTextureAtlas(named: "GohanMelee")
        let numImages = meleeAtlas.textureNames.count - 1
        for i in 0...numImages {
            let meleeTextureName = "Gohan_Melee\(i)"
            GohanMeleeFrames.append(meleeAtlas.textureNamed(meleeTextureName))
        }
        let firstFrameTexture = GohanMeleeFrames[0]
        GohanSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildKickAnimation() {
        let kickAtlas = SKTextureAtlas(named: "GohanKick")
        let numImages = kickAtlas.textureNames.count - 1
        for i in 0...numImages {
            let kickTextureName = "Gohan_Kick\(i)"
            GohanKickFrames.append(kickAtlas.textureNamed(kickTextureName))
        }
        let firstFrameTexture = GohanKickFrames[0]
        GohanSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildJumpAnimation() {
        let jumpAtlas = SKTextureAtlas(named: "GohanJump")
        let numImages = jumpAtlas.textureNames.count - 1
        for i in 0...numImages {
            let jumpTextureName = "Gohan_Jump\(i)"
            GohanJumpFrames.append(jumpAtlas.textureNamed(jumpTextureName))
        }
        let firstFrameTexture = GohanJumpFrames[0]
        GohanSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildSquatAnimation() {
        let squatAtlas = SKTextureAtlas(named: "GohanSquat")
        let numImages = squatAtlas.textureNames.count - 1
        for i in 0...numImages {
            let squatTextureName = "Gohan_Squat\(i)"
            GohanSquatFrames.append(squatAtlas.textureNamed(squatTextureName))
        }
        let firstFrameTexture = GohanSquatFrames[0]
        GohanSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildForwardAnimation() {
        let forwardAtlas = SKTextureAtlas(named: "GohanForward")
        let numImages = forwardAtlas.textureNames.count - 1
        for i in 0...numImages {
            let forwardTextureName = "Gohan_Forward\(i)"
            GohanForwardFrames.append(forwardAtlas.textureNamed(forwardTextureName))
        }
        let firstFrameTexture = GohanForwardFrames[0]
        GohanSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildBackwardAnimation() {
        let backwardAtlas = SKTextureAtlas(named: "GohanBackward")
        let numImages = backwardAtlas.textureNames.count - 1
        for i in 0...numImages {
            let backwardTextureName = "Gohan_Backward\(i)"
            GohanBackwardFrames.append(backwardAtlas.textureNamed(backwardTextureName))
        }
        let firstFrameTexture = GohanBackwardFrames[0]
        GohanSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    func idle(){
          GohanSprite.run(SKAction.repeatForever(SKAction.animate(with: GohanIdleFrames, timePerFrame:0.2, resize: true, restore: true)),withKey:"GohanIdle")
    }
    
    func kick(){
        
        GohanSprite.run(SKAction.animate(with: GohanKickFrames, timePerFrame:0.2, resize: true, restore: true),withKey:"GohanKick")
    }
    
    func melee(){
        GohanSprite.run(SKAction.animate(with: GohanMeleeFrames, timePerFrame:0.2, resize: true, restore: true),withKey:"GohanMelee")
    }
    
    func fire(){
        GohanSprite.run(SKAction.animate(with: GohanFireFrames, timePerFrame:0.2, resize: true, restore: true),withKey:"GohanFire")
    }
    
    func jump(){
        GohanSprite.run(SKAction.animate(with: GohanJumpFrames, timePerFrame:0.2, resize: true, restore: true),withKey:"GohanJump")
    }
    
    func squat(){
        GohanSprite.run(SKAction.animate(with: GohanSquatFrames, timePerFrame:0.2, resize: true, restore: true),withKey:"GohanSquat")
    }
    
    func forward(){
        GohanSprite.run(SKAction.animate(with: GohanForwardFrames, timePerFrame:0.2, resize: true, restore: true),withKey:"GohanForward")
    }
    
    func backward(){
        GohanSprite.run(SKAction.animate(with: GohanBackwardFrames, timePerFrame:0.2, resize: true, restore: true),withKey:"GohanBackward")
    }
    
}

