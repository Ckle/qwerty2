//
//  TitleScene.swift
//  qwerty2
//
//  Created by Chris Lee on 2014-12-17.
//  Copyright (c) 2014 Coffee Digital. All rights reserved.
//

import UIKit
import SpriteKit

class TitleScene: SKScene {
    
    let greenNode = SKSpriteNode(color: SKColor .greenColor(), size: CGSizeMake(150.0, 100.0))
    let playButton = SKLabelNode(fontNamed: "Helvetica Neue")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.greenNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(greenNode)
        //let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        
        playButton.text = "Play"
        self.addChild(playButton)
        self.playButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        //myLabel.fontSize = 65;
        //myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        //self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if self.nodeAtPoint(location) == self.greenNode {
                var scene = LevelScene(size: self.size)
                let skView = self.view as SKView!
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = skView.bounds.size
                skView.presentScene(scene)
            }
        }
//        if (playNode != nil) {
//            let fadeAway = SKAction.fadeOutWithDuration(1.0)
//
//            playNode?.runAction(fadeAway, completion: {
//                let doors = SKTransition.doorwayWithDuration(1.0)
//                var scene = GameScene(size: self.size)
//                self.view?.presentScene(scene, transition: doors)
//            })
//        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
