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
let enemyCategory: UInt32 = 0x1 << 2
let fireCategory: UInt32 = 0x1 << 3
let enemyFireCategory: UInt32 = 0x1 << 4

var playerIsHuring = false
var playerAttacking = false
var enemyAttacking = false

var waitToBegin = 0

public var winner = ""

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    enum NodesZPosition: CGFloat{
        case background, player, controller, hpBar, UI
    }
    
    enum playerAction{
        case Idle, Punch, Kick, Fire
    }
    
    let controller = OnScreenController()
    let player = Gohan()
    let enemy = Piccolo()
    let UI = UIManager()
    let fire = Fire()
    let piccoloBullet = Fire()

    var isRetreat = false
    var isMoveAnim = false
    var canFireDistAtk = false
    
    var inAttack = playerAction.Idle
    
    var GohanMeleeSound = SKAction()
    var GohanKickSound = SKAction()
    var GohanFireSound = SKAction()
    var GohanHitSound = SKAction()
    var PiccoloHitSound = SKAction()
    var PiccoloFireSound = SKAction()
    var PiccoloAtkSound1 = SKAction()
    var PiccoloAtkSound2 = SKAction()
    var PiccoloMeleeSound = SKAction()
    
    
    lazy var background:SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "budokai")
        sprite.zPosition = NodesZPosition.background.rawValue
        sprite.size = frame.size
        sprite.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        sprite.position = CGPoint(x: size.width / 2.0, y: 0.0)
        return sprite
    }()
    
    override init(size: CGSize){
        super.init(size: size)
        self.physicsWorld.contactDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNodes(){
        addChild(background)
        addChild(player.GohanSprite)
        addChild(enemy.PiccoloSprite)
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
    
        let wallRect = CGRect(x: 0, y: 50, width: self.frame.size.width, height: self.frame.size.height)
        let borderBody = SKPhysicsBody(edgeLoopFrom: wallRect)
        self.physicsBody =  borderBody
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        
        self.physicsBody?.categoryBitMask = wallCategory
        self.physicsBody?.contactTestBitMask = playerCategory | enemyCategory | enemyFireCategory | fireCategory
        self.physicsBody?.collisionBitMask = playerCategory | enemyCategory
        
        player.GohanSprite.physicsBody = SKPhysicsBody(texture: (player.GohanSprite.texture)!, size: (player.GohanSprite.size))
        player.GohanSprite.physicsBody?.affectedByGravity = true
        player.GohanSprite.physicsBody?.mass = 1.8
        player.GohanSprite.physicsBody?.allowsRotation = false
        player.GohanSprite.physicsBody?.categoryBitMask = playerCategory
        player.GohanSprite.physicsBody?.contactTestBitMask = enemyCategory | wallCategory | enemyFireCategory
        player.GohanSprite.physicsBody?.collisionBitMask = enemyCategory | wallCategory | enemyFireCategory
        player.GohanSprite.physicsBody?.isDynamic = true
        
        enemy.PiccoloSprite.physicsBody = SKPhysicsBody(texture: (enemy.PiccoloSprite.texture)!, size: (enemy.PiccoloSprite.size))
        enemy.PiccoloSprite.physicsBody?.affectedByGravity = true
        enemy.PiccoloSprite.physicsBody?.mass = 3.5
        enemy.PiccoloSprite.physicsBody?.allowsRotation = false
        enemy.PiccoloSprite.physicsBody?.categoryBitMask = enemyCategory
        enemy.PiccoloSprite.physicsBody?.contactTestBitMask = playerCategory | wallCategory | fireCategory
        enemy.PiccoloSprite.physicsBody?.collisionBitMask = playerCategory | wallCategory | fireCategory
        enemy.PiccoloSprite.physicsBody?.isDynamic = true
        
        fire.fireSprite.physicsBody = SKPhysicsBody(texture: (fire.fireSprite.texture)!, size: (fire.fireSprite.size))
        fire.fireSprite.physicsBody?.affectedByGravity = false
        fire.fireSprite.physicsBody?.allowsRotation = false
        fire.fireSprite.physicsBody?.categoryBitMask = fireCategory
        fire.fireSprite.physicsBody?.contactTestBitMask = enemyCategory
        fire.fireSprite.physicsBody?.collisionBitMask = enemyCategory
        fire.fireSprite.physicsBody?.isDynamic = true
        
        piccoloBullet.fireSprite.physicsBody = SKPhysicsBody(texture: (fire.fireSprite.texture)!, size: (fire.fireSprite.size))
        piccoloBullet.fireSprite.physicsBody?.affectedByGravity = false
        piccoloBullet.fireSprite.physicsBody?.allowsRotation = false
        piccoloBullet.fireSprite.physicsBody?.categoryBitMask = enemyFireCategory
        piccoloBullet.fireSprite.physicsBody?.contactTestBitMask = playerCategory
        piccoloBullet.fireSprite.physicsBody?.collisionBitMask = playerCategory
        piccoloBullet.fireSprite.physicsBody?.isDynamic = true
    }
    
    func setControllerPosition(){
        controller.analogJoystick.zPosition = NodesZPosition.controller.rawValue
        controller.kickButton.zPosition = NodesZPosition.controller.rawValue
        controller.punchButton.zPosition = NodesZPosition.controller.rawValue
        controller.fireButton.zPosition = NodesZPosition.controller.rawValue
        controller.analogJoystick.position = CGPoint(x: controller.analogJoystick.radius + 50, y: frame.size.height/5.5)
        controller.kickButton.position = CGPoint(x: self.size.width - 110, y: self.frame.size.height/4)
        controller.punchButton.position = CGPoint(x: self.size.width - 160, y: self.frame.size.height/7.5)
        controller.fireButton.position = CGPoint(x: self.size.width - 60, y: self.frame.size.height/7.5)
    }
    
    func setActorPosition(){
        player.GohanSprite.position = CGPoint(x: frame.maxX - frame.maxX/6, y: player.GohanSprite.size.height)
        player.GohanSprite.zPosition = NodesZPosition.player.rawValue
        player.GohanSprite.setScale(1.2)
        
        enemy.PiccoloSprite.position = CGPoint(x: frame.maxX/6, y: player.GohanSprite.size.height)
        enemy.PiccoloSprite.zPosition = NodesZPosition.player.rawValue
        enemy.PiccoloSprite.setScale(1.2)
        enemy.PiccoloSprite.xScale = -1
    }
    
    func setHudPosition(){
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
    
    func setNodesPositions(){
        setControllerPosition()
        setActorPosition()
        setHudPosition()
    }
    
    func addSound()
    {
        let BGM = SKAudioNode(fileNamed: "CHA-LA_HEAD-CHA-LA.mp3")
        addChild(BGM)
        BGM.run(SKAction.play())
        
        GohanMeleeSound = SKAction.playSoundFileNamed("GohanMelee.wav", waitForCompletion: false)
        GohanKickSound = SKAction.playSoundFileNamed("GohanKick.wav", waitForCompletion: false)
        GohanHitSound = SKAction.playSoundFileNamed("GohanIsHit.wav", waitForCompletion: false)
        GohanFireSound = SKAction.playSoundFileNamed("GohanFire.wav", waitForCompletion: false)
        
        PiccoloHitSound = SKAction.playSoundFileNamed("PiccoloIsHit.wav", waitForCompletion: false)
        PiccoloFireSound = SKAction.playSoundFileNamed("PiccoloFire.wav", waitForCompletion: false)
        PiccoloAtkSound1 = SKAction.playSoundFileNamed("PiccoloAttack1.wav", waitForCompletion: false)
        PiccoloAtkSound2 = SKAction.playSoundFileNamed("PiccoloAttack2.wav", waitForCompletion: false)
        PiccoloMeleeSound = SKAction.playSoundFileNamed("PiccoloMelee.wav", waitForCompletion: false)
    }
    
    
    override func didMove(to view: SKView) {
        addSound()
        setupNodes()
        setNodesPositions()
    
        player.idle()
        enemy.idle()
        setPhysics()
        
        waitToBegin += 1
        UI.counter = UI.counterStartVal
        UI.startCounter()
        
        addChild(fire.fireSprite)
        fire.fireSprite.isHidden = true
        
        addChild(piccoloBullet.fireSprite)
        piccoloBullet.fireSprite.isHidden = true
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
    
    func getDirection() -> CGFloat{
        var multiplierForDirection: CGFloat
        let moveDifference = enemy.PiccoloSprite.position.x - player.GohanSprite.position.x
        if moveDifference < 0 {
            multiplierForDirection = -1.0
        } else {
            multiplierForDirection = 1.0
        }
        return multiplierForDirection
    }
    
    func movePlayer(){
        controller.checkDirection()
        
        //player control setup
        //move left and right
        if isTouched && abs(controller.analogJoystick.data.velocity.x)>=5 {
            if controller.stickPoint == "right"{
                player.GohanSprite.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 10))
                
                if player.GohanSprite.xScale == 1{
                    player.backward()
                }else{
                    player.forward()
                }
            }
            if controller.stickPoint == "left"{
                player.GohanSprite.physicsBody?.applyImpulse(CGVector(dx: -30, dy: 10))
                
                if player.GohanSprite.xScale == -1{
                    player.backward()
                }else{
                    player.forward()
                }
            }
        }
        //squat
        if controller.analogJoystick.tracking && controller.stickPoint == "down"{
            player.squat()
        }
        //jump
        if round(controller.analogJoystick.data.velocity.y)==50 {
            if controller.stickPoint == "up"{
                player.GohanSprite.physicsBody?.applyImpulse(CGVector(dx: 10.0*getDirection(), dy: 120))
                player.jump()
            }
        }
    }
    
    func piccoloShoot(){
        piccoloBullet.fireSprite.removeFromParent()
        piccoloBullet.fireSprite.zPosition = NodesZPosition.player.rawValue
        piccoloBullet.fireSprite.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        piccoloBullet.fireSprite.position.x = enemy.PiccoloSprite.position.x - enemy.PiccoloSprite.size.width/1.5 * getDirection()
        piccoloBullet.fireSprite.position.y = enemy.PiccoloSprite.size.height
        piccoloBullet.fireSprite.xScale = enemy.PiccoloSprite.xScale
        piccoloBullet.fireSprite.isHidden = false
        addChild(piccoloBullet.fireSprite)
        
        piccoloBullet.shootAni()
        piccoloBullet.fireSprite.physicsBody?.applyImpulse(CGVector(dx: -piccoloBullet.fireSprite.xScale * 10, dy: -1.2))
    }
    
    func enemyRetreat(){
        enemy.backward()
        enemyAttacking = false
        isRetreat = false
        let multiplier = getDirection()
        enemy.PiccoloSprite.run(SKAction.moveBy(x: 150 * multiplier, y: 0, duration: 0.5))
    }
    
    func pickEnemyAction(){
        let randomInt = Int.random(in: 1..<10)
        if randomInt == 1{
            enemy.Punch()
            run(PiccoloAtkSound2)
        }
        if randomInt == 2{
            enemy.kick()
            run(PiccoloAtkSound2)
        }
        if randomInt == 3{
            enemy.heavyPunch()
            run(PiccoloAtkSound1)
        }
        if randomInt == 4{
            enemy.spinKick()
            run(PiccoloAtkSound1)
        }
        if randomInt == 5{
            enemy.melee()
            run(PiccoloMeleeSound)
        }
        if randomInt == 6 || randomInt == 7 {
            enemyRetreat()
            isRetreat = true
        }
        if randomInt > 7{
            if UI.enemyHpBar.size.width <= 100{
                enemyRetreat()
                isRetreat = true
            }else{
                enemy.melee()
                run(PiccoloMeleeSound)
            }
        }
    }
    
    func distanceAtk(){
        canFireDistAtk = true

        let randomInt = Int.random(in: 1..<6)
        if randomInt < 3{
            enemy.fire()
            piccoloShoot()
            run(PiccoloFireSound)
        }
        if randomInt >= 3 && randomInt < 5{
            enemy.jump()
            enemy.PiccoloSprite.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 2000))
        }
        if randomInt >= 5{
            enemy.forward()
            enemy.PiccoloSprite.physicsBody?.applyImpulse(CGVector(dx: -1000*getDirection(), dy: 0))
        }
    }
    
    
    func moveEnemy(){
        
        let distance = player.GohanSprite.position.x - enemy.PiccoloSprite.position.x
        if distance < 0{
            enemy.PiccoloSprite.xScale = 1
        }else{
            enemy.PiccoloSprite.xScale = -1
        }
        
        if !isMoveAnim && !enemyAttacking{
            enemy.move()
            isMoveAnim = true
        }

        if !isRetreat{
            //moving toward player
            let multiplier = getDirection()
            enemy.PiccoloSprite.physicsBody?.applyImpulse(CGVector(dx: -30 * multiplier, dy: 0))
        }
        
        if abs(distance) <= 93 && abs(distance) >= 89 && !enemyAttacking{
            isMoveAnim = false
            pickEnemyAction()
        }
        
        if abs(distance) > 95 && abs(distance) <= 400{
            isRetreat = false
        }
        
        if abs(distance) <= 400{
            canFireDistAtk = false
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        movePlayer()
//        print("Pico attacking: \(enemyAttacking)")
//        print("Gohan attacking: \(enemyAttacking)")
        
        //activate enemy's movement
        let distance = player.GohanSprite.position.x - enemy.PiccoloSprite.position.x
        if abs(distance) >= 80 && abs(distance) <= 400{
           moveEnemy()
        }
        if abs(distance) >= 400 && !canFireDistAtk && UI.counter <= 180{
            distanceAtk()
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
        
        if distance < 0{
            player.GohanSprite.xScale = -1
        }else{
            player.GohanSprite.xScale = 1
        }
    }
    
    func setFirePosition(){
        fire.fireSprite.removeFromParent()
        fire.fireSprite.zPosition = NodesZPosition.player.rawValue
        fire.fireSprite.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        fire.fireSprite.position.x = player.GohanSprite.position.x
        fire.fireSprite.position.y = player.GohanSprite.position.y + 25
        fire.fireSprite.xScale = player.GohanSprite.xScale
        fire.fireSprite.isHidden = false
        addChild(fire.fireSprite)
    }
    
    func shootFire(){
        fire.shootAni()
        fire.fireSprite.physicsBody?.applyImpulse(CGVector(dx: -fire.fireSprite.xScale * 10, dy: 0))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches {
            let location = t.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "FireButton" {
                player.fire()
                setFirePosition()
                shootFire()
                inAttack = playerAction.Fire
                run(GohanFireSound)
            }
            if touchedNode.name == "PunchButton" {
                player.melee()
                inAttack = playerAction.Punch
                run(GohanMeleeSound)
            }
            if touchedNode.name == "KickButton" {
                player.kick()
                inAttack = playerAction.Kick
                run(GohanKickSound)
            }
        }
    }
    
    func blackOrDamage(){
        let randomInt = Int.random(in: 1..<6)
        if randomInt < 3{
            enemy.block()
        }else{
            enemy.isHit()
        }
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contactCategory = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactCategory{
        case enemyCategory | fireCategory:
            let fireNode = contact.bodyA.categoryBitMask == fireCategory ? contact.bodyA.node : contact.bodyB.node
            enemy.isHit()
            run(PiccoloHitSound)
            fireNode?.removeFromParent()
            setDamage(name: UI.enemyHpBar, damage: 5)
            break
        case playerCategory | enemyFireCategory:
            let fireNode = contact.bodyA.categoryBitMask == enemyFireCategory ? contact.bodyA.node : contact.bodyB.node
            fireNode?.removeFromParent()
            player.isHit()
            run(GohanHitSound)
            setDamage(name: UI.playerHpBar, damage: 7)
            break
            
        case playerCategory | enemyCategory:
            if playerAttacking {
                print("Gohan atk")
                enemy.isHit()
                run(PiccoloHitSound)
                if inAttack == playerAction.Punch{
                    setDamage(name: UI.enemyHpBar, damage: 3)
                }
                if inAttack == playerAction.Kick{
                    setDamage(name: UI.enemyHpBar, damage: 8)
                }
            }
            if enemyAttacking && !playerIsHuring{
                print("Picco atk")
                playerIsHuring = true
                let randomDamage = Int.random(in: 5...10)
                setDamage(name: UI.playerHpBar, damage: CGFloat(randomDamage))
                player.isHit()
                run(GohanHitSound)
            }
            if !enemyAttacking && !playerAttacking{
                print("Nobody atk")
                enemyRetreat()
            }
            if enemyAttacking && playerAttacking{
                enemyRetreat()
            }
            break

        default: break
        }
    }
}
