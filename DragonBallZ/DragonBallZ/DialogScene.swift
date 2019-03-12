//
//  DialogScene.swift
//  DragonBallZ
//
//  Created by Jamie on 2019/3/10.
//  Copyright © 2019 Jamie. All rights reserved.
//

import SpriteKit
import GameplayKit

class DialogScene: SKScene {
    
    private var GohanSprite = SKSpriteNode()
    private var GohanFrames: [SKTexture] = []
    private var PiccoloSprite = SKSpriteNode()
    private var PiccoloFrames: [SKTexture] = []
    private let dialogueLabel = SKLabelNode(fontNamed: "Consolas")
    private var cut = 0;
    private var PiccoloIsTalking = true;
    private var oneCutFinished = false;
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize){
        super.init(size: size)
        
        let background = SKSpriteNode(imageNamed: "bg1")
        background.size = frame.size
        background.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        background.position = CGPoint(x: size.width / 2.0, y: self.size.height/4)
        background.zPosition = -2
        addChild(background)
    }
    
    func addDialogueBase(){
        let dialogueBase = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height/3.5))
        dialogueBase.zPosition = 0
//        dialogueBase.fillColor = UIColor(displayP3Red: 0.90, green:0.81, blue:0.46, alpha:1.0)
        dialogueBase.fillColor = UIColor.darkGray
        addChild(dialogueBase)
    }
    
    func addDialogueLabel(){
        dialogueLabel.fontSize = 30
        dialogueLabel.position = CGPoint(x: 20, y: self.frame.maxY/6)
        dialogueLabel.horizontalAlignmentMode = .left
        dialogueLabel.verticalAlignmentMode = .center
        dialogueLabel.lineBreakMode = .byWordWrapping
        dialogueLabel.numberOfLines = 0
        dialogueLabel.preferredMaxLayoutWidth = self.frame.width - 20
        dialogueLabel.color = UIColor.white
        dialogueLabel.colorBlendFactor = 1
        dialogueLabel.zPosition = 1
        addChild(dialogueLabel)
    }
    
    func setMugshotSprite(){
        let GohanImages = 2
        for i in 0..<GohanImages {
            GohanFrames.append(SKTexture(imageNamed: "GohanMugshot_\(i)"))
            let GohanTexture = GohanFrames[i]
            GohanSprite = SKSpriteNode(texture: GohanTexture)
            GohanSprite.name = "Gohan"
        }
        
        let PiccoloImages = 3
        for i in 0..<PiccoloImages {
            PiccoloFrames.append(SKTexture(imageNamed: "piccolo_mugshot_\(i)"))
            let PiccoloTexture = PiccoloFrames[i]
            PiccoloSprite = SKSpriteNode(texture: PiccoloTexture)
            PiccoloSprite.name = "Piccolo"
        }
    }
    
    func addMugShot(Name spriteName:SKSpriteNode, IsLeft isLeft:Bool){
        let mugShot = spriteName
        mugShot.setScale(2)
        if isLeft == true{
            mugShot.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            mugShot.position = CGPoint(x: self.frame.minX, y: self.frame.size.height/4.5)
        }else{
            mugShot.anchorPoint = CGPoint(x: 1, y: 0.0)
            mugShot.position = CGPoint(x: self.frame.maxX, y: self.frame.size.height/4.5)
        }
        mugShot.zPosition = -1
        addChild(mugShot)
    }
    



    
    func dialogueCut(Cut cut:Int){
        
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let fadeSeq = SKAction.sequence([fadeIn,fadeOut])
        
        if(PiccoloIsTalking){
            fadeCharacter(Name: GohanSprite, IsOut: true)
            fadeCharacter(Name: PiccoloSprite, IsOut: false)
            dialogueLabel.color = UIColor.init(displayP3Red: 0.55, green:0.94, blue:0.69, alpha:1.0)
        }else{
//            dialogueLabel.run(fadeIn)
            fadeCharacter(Name: GohanSprite, IsOut: false)
            fadeCharacter(Name: PiccoloSprite, IsOut: true)
            dialogueLabel.color = UIColor.white
        }
        
        if cut == 0 {
            if PiccoloIsTalking{
                dialogueLabel.text = "Kid, Now I've taught you all. Let's do some practical fighting tests"
            }else{
                dialogueLabel.text = "Uh? I thought you're gonna show me more skills, aren't you?"
                oneCutFinished = true;
            }
        }else if cut == 1 {
            if PiccoloIsTalking{
                dialogueLabel.text = "No more. Time for you to do the real fight."
            }else{
                dialogueLabel.text = "Auh... but I can't. I'm not ready yet."
                oneCutFinished = true;
            }
        }else if cut == 2{
            if PiccoloIsTalking{
                dialogueLabel.text = "Stop acting like a coward. I won't kill you. Just be tough!"
            }else{
                dialogueLabel.text = "All right. I will try. Let's start."
                oneCutFinished = true;
            }
        }
    }
    
    func fadeCharacter(Name name:SKSpriteNode, IsOut isOut:Bool){
        let colorize = SKAction.colorize(with: UIColor.gray, colorBlendFactor: 1, duration: 0.5)
        let fadeAlpha = SKAction.fadeAlpha(by: 0.7, duration: 0.5)
        let fadeAlphaBack = SKAction.fadeAlpha(by: 1, duration: 0.5)
        let colorBack = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1, duration: 0.5)
        var changeLookSeq = SKAction()
        if isOut{
            changeLookSeq = SKAction.sequence([fadeAlpha,colorize])
        }else{
            changeLookSeq = SKAction.sequence([fadeAlphaBack,colorBack])
        }
        name.run(changeLookSeq)
    }
    
    func fadeDialogue()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let fadeSeq = SKAction.sequence([fadeIn,fadeOut])
        dialogueLabel.run(fadeSeq)
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        addDialogueBase()
        setMugshotSprite()
        addDialogueLabel()
        addMugShot(Name:GohanSprite, IsLeft: false)
        addMugShot(Name: PiccoloSprite, IsLeft: true)
        dialogueCut(Cut:0)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        PiccoloIsTalking = !PiccoloIsTalking
//        fadeDialogue()
        dialogueCut(Cut:cut)
        if (oneCutFinished) {
            cut += 1
            oneCutFinished = false
        }
        
        for t in touches {
            let location = t.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "Gohan" {
                fadeCharacter(Name: GohanSprite, IsOut: true)
//                GohanSprite.texture = GohanFrames[0]
            }
            
            if touchedNode.name == "Piccolo"{
                PiccoloSprite.texture = PiccoloFrames[0]
            }
            
            if t.tapCount == 2{
//                fadeCharacter(IsOut: false)
            }
        }
    }
    
    //p:Kid, Now I've taught you all. Let's do some practical fighting tests
    //h:Uh? I thought you're gonna show me more, aren't you?
    //p:No more. Time for you to do the real fight.
    //h:Auh... but I can't. I'm not ready yet.
    //p:Stop acting like a coward. I won't kill you. Just be tough!
    //h:All right. I will try.
    
}
