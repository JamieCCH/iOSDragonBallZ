//
//  OnScreenController.swift
//  DragonBallZ
//
//  Created by Jamie on 2019/3/18.
//  Copyright © 2019 Jamie. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

public class OnScreenController:SKNode {
    
    let velocityMultiplier: CGFloat = 0.05
    var angle = CGFloat(0)
    var stickPoint = ""
    
    lazy var analogJoystick: AnalogJoystick = {
        let js = AnalogJoystick(diameters: (100,50), colors: nil, images: (substrate: #imageLiteral(resourceName: "joystickBase"), stick: #imageLiteral(resourceName: "joystick")))
        return js
    }()
    
    lazy var kickButton:SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "buttonA")
        sprite.setScale(0.6)
        sprite.name = "KickButton"
        return sprite
    }()
    
    lazy var punchButton:SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "buttonB")
        sprite.setScale(0.6)
        sprite.name = "PunchButton"
        return sprite
    }()
    
    lazy var fireButton:SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "buttonFire")
        sprite.setScale(0.6)
        sprite.name = "FireButton"
        return sprite
    }()
    
    //Convert to degrees: 0° is up, 90° is right, 180° is down and 270° is left
    func getStickAngle() {
        if (analogJoystick.data.velocity != CGPoint.zero){
            if analogJoystick.data.angular < 0 {
                angle = -analogJoystick.data.angular * 180.0 / .pi
            }else{
                angle = 360 - (analogJoystick.data.angular * 180.0 / .pi)
            }
        }
//        print(angle)
    }
    
    func checkDirection(){
        
        self.getStickAngle()

        if angle <= 170{
            stickPoint = "right"
        }else if angle >= 190 && angle <= 350{
            stickPoint = "left"
        }
        if angle > 350 || angle < 10{
            stickPoint = "up"
        }else if angle > 170 && angle < 190{
            stickPoint = "down"
        }
    }
    
//    func setupJoystick(player playerName:SKSpriteNode) {
//        analogJoystick.trackingHandler = { [unowned self] data in
//            playerName.position.x = playerName.position.x + (data.velocity.x * self.velocityMultiplier)
//            playerName.position = CGPoint(x: playerName.position.x + (data.velocity.x * self.velocityMultiplier),y: playerName.position.y + (data.velocity.y * self.velocityMultiplier))
//        }
//    }

//to set touchesBegan here is not working
//    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touch")
//    }
    
}
