//
//  LevelFinishedScene.swift
//  qwerty2
//
//  Created by Chris Lee on 2015-01-24.
//  Copyright (c) 2015 Coffee Digital. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class LevelFinishedScene: SKScene {
    
    let Level1Node = SKSpriteNode(color: SKColor .greenColor(), size: CGSizeMake(150.0, 100.0))
    let youLoseNode = SKLabelNode(fontNamed: "Helvetica Neue")
    let youWinNode = SKLabelNode(fontNamed: "Helvetica Neue")
    
    override func didMoveToView(view: SKView) {
        
        Level1Node.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        youLoseNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 100)
        youWinNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 100)
        
        youWinNode.text = "You Win!"
        
        self.addChild(Level1Node)
        self.addChild(youWinNode)
        self.backgroundColor = UIColor(red: 81/255, green: 150/255, blue: 111/255, alpha: 1.0)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if self.nodeAtPoint(location) == self.Level1Node {
                var scene = GameScene(size: self.size)
                self.view?.presentScene(scene)
            }
        }
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}