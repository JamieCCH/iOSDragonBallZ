//
//  UIManager.swift
//  DragonBallZ
//
//  Created by Jamie on 2019/3/18.
//  Copyright © 2019 Jamie. All rights reserved.
//

import Foundation
import SpriteKit

public class UIManager{

    var playerHp = SKShapeNode()
    var enemyHp = SKShapeNode()
    var isGameOver = false
    var counter = 0
    var counterTimer = Timer()
    var counterStartVal = 180

    lazy var timerLabel:SKLabelNode = {
        var label = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        label.text = "3:00"
        label.fontColor = UIColor(displayP3Red:0.49, green:0.12, blue:0.12, alpha:1.0)
        label.horizontalAlignmentMode = .center
        return label
    }()
    
    lazy var playerMugshot:SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "GohanMugshot")
        sprite.setScale(0.2)
        return sprite
    }()
    
    lazy var enemyMugshot:SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "PiccoloMugshot")
        sprite.setScale(0.2)
        return sprite
    }()
    
    lazy var playerHpBar:SKSpriteNode = {
        var rectangle = SKSpriteNode(color: UIColor.green, size: CGSize(width: 230.0, height: 30.0))
        return rectangle
    }()
    
    lazy var enemyHpBar:SKSpriteNode = {
        var rectangle = SKSpriteNode(color: UIColor.green, size: CGSize(width: 230.0, height: 30.0))
        return rectangle
    }()
    
    func startCounter(){
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCountDown), userInfo: nil, repeats: true)
    }
    
    @objc func timerCountDown(){
        if !isGameOver{
            if counter <= 1{
                isGameOver = true
            }
            
            counter -= 1
            let min = counter / 60
            let sec = counter % 60
            let minText = min < 10 ? "0\(min)" : "\(min)"
            let secText = sec < 10 ? "0\(sec)" : "\(sec)"
            
            timerLabel.text = "\(minText):\(secText)"
        }
    }
    
//    func hpBarSetting(name:SKShapeNode, defRect:CGRect){
//        name.path = UIBezierPath(rect: defRect).cgPath
//        name.fillColor = UIColor.red
//        name.lineWidth = 0
//    }

}
