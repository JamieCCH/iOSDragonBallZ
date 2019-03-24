//
//  Piccolo.swift
//  DragonBallZ
//
//  Created by Jamie on 2019/3/23.
//  Copyright © 2019 Jamie. All rights reserved.
//

import Foundation
import SpriteKit

public class Piccolo {
    
    var PiccoloSprite:SKSpriteNode
    private var PiccoloIdleFrames: [SKTexture] = []
    private var PiccoloFireFrames: [SKTexture] = []
    private var PiccoloPunchFrames: [SKTexture] = []
    private var PiccoloKickFrames: [SKTexture] = []
    private var PiccoloJumpFrames: [SKTexture] = []
    private var PiccoloForwardFrames: [SKTexture] = []
    private var PiccoloBackwardFrames: [SKTexture] = []
    private var PiccoloMoveFrames: [SKTexture] = []
    private var PiccoloHeavyPunchFrames: [SKTexture] = []
    private var PiccoloSpinKickFrames: [SKTexture] = []
    private var PiccoloIsHitFrames: [SKTexture] = []
    private var PiccoloBlockFrames: [SKTexture] = []
    
    public init(){
        PiccoloSprite = SKSpriteNode()
        buildBlockAnimation()
        buildFireAnimation()
        buildMileeAnimation()
        buildKickAnimation()
        buildJumpAnimation()
        buildForwardAnimation()
        buildBackwardAnimation()
        buildSpinKickAnimation()
        buildHeavyPunchAnimation()
        buildIdleAnimation()
        buildIsHitAnimation()
        buildMoveAnimation()
    }
    
    private func buildBlockAnimation(){
        let blockAtlas = SKTextureAtlas(named: "PiccoloBlock")
        let numImages = blockAtlas.textureNames.count - 1
        for i in 0...numImages {
            let blockTextureName = "Piccolo_Block\(i)"
            PiccoloBlockFrames.append(blockAtlas.textureNamed(blockTextureName))
        }
        let firstFrameTexture = PiccoloBlockFrames[0]
        PiccoloSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildIsHitAnimation() {
        let isHitAtlas = SKTextureAtlas(named: "PiccoloIsHit")
        let numImages = isHitAtlas.textureNames.count - 1
        for i in 0...numImages {
            let isHitTextureName = "Piccolo_IsHit\(i)"
            PiccoloIsHitFrames.append(isHitAtlas.textureNamed(isHitTextureName))
        }
        let firstFrameTexture = PiccoloIsHitFrames[0]
        PiccoloSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildIdleAnimation() {
        let idleAtlas = SKTextureAtlas(named: "PiccoloIdle")
        let numImages = idleAtlas.textureNames.count - 1
        for i in 0...numImages {
            let idleTextureName = "Piccolo_Idle\(i)"
            PiccoloIdleFrames.append(idleAtlas.textureNamed(idleTextureName))
        }
        let firstFrameTexture = PiccoloIdleFrames[0]
        PiccoloSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildMoveAnimation() {
        let moveAtlas = SKTextureAtlas(named: "PiccoloMove")
        let numImages = moveAtlas.textureNames.count - 1
        for i in 0...numImages {
            let moveTextureName = "Piccolo_Move\(i)"
            PiccoloMoveFrames.append(moveAtlas.textureNamed(moveTextureName))
        }
        let firstFrameTexture = PiccoloMoveFrames[0]
        PiccoloSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildFireAnimation() {
        let fireAtlas = SKTextureAtlas(named: "PiccoloFire")
        let numImages = fireAtlas.textureNames.count - 1
        for i in 0...numImages {
            let fireTextureName = "Piccolo_Fire\(i)"
            PiccoloFireFrames.append(fireAtlas.textureNamed(fireTextureName))
        }
        let firstFrameTexture = PiccoloFireFrames[0]
        PiccoloSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildMileeAnimation() {
        let PunchAtlas = SKTextureAtlas(named: "PiccoloPunch")
        let numImages = PunchAtlas.textureNames.count - 1
        for i in 0...numImages {
            let PunchTextureName = "Piccolo_Punch\(i)"
            PiccoloPunchFrames.append(PunchAtlas.textureNamed(PunchTextureName))
        }
        let firstFrameTexture = PiccoloPunchFrames[0]
        PiccoloSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildKickAnimation() {
        let kickAtlas = SKTextureAtlas(named: "PiccoloKick")
        let numImages = kickAtlas.textureNames.count - 1
        for i in 0...numImages {
            let kickTextureName = "Piccolo_Kick\(i)"
            PiccoloKickFrames.append(kickAtlas.textureNamed(kickTextureName))
        }
        let firstFrameTexture = PiccoloKickFrames[0]
        PiccoloSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildSpinKickAnimation() {
        let spinKickAtlas = SKTextureAtlas(named: "PiccoloSpinKick")
        let numImages = spinKickAtlas.textureNames.count - 1
        for i in 0...numImages {
            let spinKickTextureName = "Piccolo_SpinKick\(i)"
            PiccoloSpinKickFrames.append(spinKickAtlas.textureNamed(spinKickTextureName))
        }
        let firstFrameTexture = PiccoloSpinKickFrames[0]
        PiccoloSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildHeavyPunchAnimation() {
        let heavyPunchAtlas = SKTextureAtlas(named: "PiccoloHeavyPunch")
        let numImages = heavyPunchAtlas.textureNames.count - 1
        for i in 0...numImages {
            let heavyPunchTextureName = "Piccolo_HeaveyPunch\(i)"
            PiccoloHeavyPunchFrames.append(heavyPunchAtlas.textureNamed(heavyPunchTextureName))
        }
        let firstFrameTexture = PiccoloHeavyPunchFrames[0]
        PiccoloSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    
    private func buildJumpAnimation() {
        let jumpAtlas = SKTextureAtlas(named: "PiccoloJump")
        let numImages = jumpAtlas.textureNames.count - 1
        for i in 0...numImages {
            let jumpTextureName = "Piccolo_Jump\(i)"
            PiccoloJumpFrames.append(jumpAtlas.textureNamed(jumpTextureName))
        }
        let firstFrameTexture = PiccoloJumpFrames[0]
        PiccoloSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildForwardAnimation() {
        let forwardAtlas = SKTextureAtlas(named: "PiccoloForward")
        let numImages = forwardAtlas.textureNames.count - 1
        for i in 0...numImages {
            let forwardTextureName = "Piccolo_Forward\(i)"
            PiccoloForwardFrames.append(forwardAtlas.textureNamed(forwardTextureName))
        }
        let firstFrameTexture = PiccoloForwardFrames[0]
        PiccoloSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    private func buildBackwardAnimation() {
        let backwardAtlas = SKTextureAtlas(named: "PiccoloBackward")
        let numImages = backwardAtlas.textureNames.count - 1
        for i in 0...numImages {
            let backwardTextureName = "Piccolo_Backward\(i)"
            PiccoloBackwardFrames.append(backwardAtlas.textureNamed(backwardTextureName))
        }
        let firstFrameTexture = PiccoloBackwardFrames[0]
        PiccoloSprite = SKSpriteNode(texture: firstFrameTexture)
    }
    
    func idle(){
        PiccoloSprite.run(SKAction.repeatForever(SKAction.animate(with: PiccoloIdleFrames, timePerFrame:0.2, resize: true, restore: true)),withKey:"PiccoloIdle")
    }
    
    func kick(){
        let beginAtk = SKAction.run{enemyAttacking = true}
        let kickAnim = SKAction.animate(with: PiccoloKickFrames, timePerFrame:0.2, resize: true, restore: true)
        let endAtk = SKAction.run{enemyAttacking = false}
        PiccoloSprite.run(SKAction.sequence([beginAtk,kickAnim,endAtk]),withKey:"PiccoloKick")
    }
    
    func Punch(){
//        PiccoloSprite.run(SKAction.animate(with: PiccoloPunchFrames, timePerFrame:0.2, resize: true, restore: true),withKey:"PiccoloPunch")
        
        let beginAtk = SKAction.run{enemyAttacking = true}
        let punchAnim = SKAction.animate(with: PiccoloPunchFrames, timePerFrame:0.2, resize: true, restore: true)
        let endAtk = SKAction.run{enemyAttacking = false}
        PiccoloSprite.run(SKAction.sequence([beginAtk,punchAnim,endAtk]),withKey:"PiccoloPunch")
    }
    
    func fire(){
//        PiccoloSprite.run(SKAction.animate(with: PiccoloFireFrames, timePerFrame:0.2, resize: true, restore: true),withKey:"PiccoloFire")
        let beginAtk = SKAction.run{enemyAttacking = true}
        let fireAnim = SKAction.animate(with: PiccoloFireFrames, timePerFrame:0.2, resize: true, restore: true)
        let endAtk = SKAction.run{enemyAttacking = false}
        PiccoloSprite.run(SKAction.sequence([beginAtk,fireAnim,endAtk]),withKey:"PiccoloFire")
    }
    
    func jump(){
//        PiccoloSprite.run(SKAction.animate(with: PiccoloJumpFrames, timePerFrame:0.2, resize: true, restore: true),withKey:"PiccoloJump")
        let beginAtk = SKAction.run{enemyAttacking = true}
        let jumpAnim = SKAction.animate(with: PiccoloJumpFrames, timePerFrame:0.2, resize: true, restore: true)
        let endAtk = SKAction.run{enemyAttacking = false}
        PiccoloSprite.run(SKAction.sequence([beginAtk,jumpAnim,endAtk]),withKey:"PiccoloJump")
    }
    
    func forward(){
//        PiccoloSprite.run(SKAction.animate(with: PiccoloForwardFrames, timePerFrame:0.45, resize: true, restore: true),withKey:"PiccoloForward")
        let beginAtk = SKAction.run{enemyAttacking = true}
        let goAnim = SKAction.animate(with: PiccoloForwardFrames, timePerFrame:0.45, resize: true, restore: true)
        let endAtk = SKAction.run{enemyAttacking = false}
        PiccoloSprite.run(SKAction.sequence([beginAtk,goAnim,endAtk]),withKey:"PiccoloForward")
    }
    
    func backward(){
        PiccoloSprite.run(SKAction.animate(with: PiccoloBackwardFrames, timePerFrame:0.2, resize: true, restore: true),withKey:"PiccoloBackward")
    }
    
    func move(){
        PiccoloSprite.run(SKAction.animate(with: PiccoloMoveFrames, timePerFrame: 0.2, resize: true, restore: true),withKey:"PiccoloMove")
    }
    
    func removeAction(actionKey: String){
        PiccoloSprite.removeAction(forKey: actionKey)
        print("remove")
    }
    
    func heavyPunch(){
//        PiccoloSprite.run(SKAction.animate(with: PiccoloHeavyPunchFrames, timePerFrame:0.25, resize: true, restore: true),withKey:"PiccoloHeavyPunch")
        let beginAtk = SKAction.run{enemyAttacking = true}
        let punchAnim = SKAction.animate(with: PiccoloHeavyPunchFrames, timePerFrame:0.25, resize: true, restore: true)
        let endAtk = SKAction.run{enemyAttacking = false}
        PiccoloSprite.run(SKAction.sequence([beginAtk,punchAnim,endAtk]),withKey:"PiccoloHeavyPunch")
    }
    
    func spinKick(){
//        PiccoloSprite.run(SKAction.animate(with: PiccoloSpinKickFrames, timePerFrame:0.25, resize: true, restore: true),withKey:"PiccoloSpinKick")
        
        let beginAtk = SKAction.run{enemyAttacking = true}
        let kickAnim = SKAction.animate(with: PiccoloSpinKickFrames, timePerFrame:0.25, resize: true, restore: true)
        let endAtk = SKAction.run{enemyAttacking = false}
        PiccoloSprite.run(SKAction.sequence([beginAtk,kickAnim,endAtk]),withKey:"PiccoloSpinKick")
    }
    
    func melee(){
        let beginAtk = SKAction.run{enemyAttacking = true}
        let kick = SKAction.animate(with: PiccoloKickFrames, timePerFrame:0.2, resize: true, restore: true)
        let Skick = SKAction.animate(with: PiccoloSpinKickFrames, timePerFrame:0.2, resize: true, restore: true)
        let Hpunch = SKAction.animate(with: PiccoloHeavyPunchFrames, timePerFrame:0.2, resize: true, restore: true)
        let endAtk = SKAction.run{enemyAttacking = false}
        PiccoloSprite.run(SKAction.sequence([beginAtk,kick,Hpunch,Skick,endAtk]),withKey:"PiccoloSpinKick")
    }
    
    func isHit(){
        PiccoloSprite.run(SKAction.animate(with: PiccoloIsHitFrames, timePerFrame:0.05, resize: true, restore: false), withKey:"PiccoloIsHit")
    }
    
    func block(){
        PiccoloSprite.run(SKAction.animate(with: PiccoloBlockFrames, timePerFrame:0.05, resize: true, restore: false), withKey:"PiccoloBlock")
    }
}
