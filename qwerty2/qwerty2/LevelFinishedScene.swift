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
    let youWinNode = SKLabelNode(fontNamed: "Helvetica Neue")
    
    let timeTaken = SKLabelNode(fontNamed: "Helvetica Neue")
    // Creates GameScene as a constant
    let gameScene: GameScene
    
    // Using the init method, passes the GameScene object as a member of GameOverScene
    // Now we should be able to access the variables in GameScene
    init(gameScene:GameScene, size: CGSize ) {
        
        self.gameScene = gameScene
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
        Level1Node.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        youWinNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 100)
        timeTaken.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+100)
        
        youWinNode.text = "You Win!"
        // Display Time taken, rounded to 2 decimals
        timeTaken.text = "Score: \(round(100*gameScene.seconds)/100)s left"
        
        self.addChild(Level1Node)
        self.addChild(youWinNode)
        self.addChild(timeTaken)
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