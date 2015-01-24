//
//  GameScene2.swift
//  qwerty2
//
//  Created by Chris Lee on 2014-12-18.
//  Copyright (c) 2014 Coffee Digital. All rights reserved.
//

import SpriteKit

class LevelScene: SKScene {
    
    let Level1Node = SKSpriteNode(color: SKColor .greenColor(), size: CGSizeMake(150.0, 100.0))
    let maxLevels = 4
    // var progressLoader: ProgressLoaderNode!
    
    override func didMoveToView(view: SKView) {
        
        self.Level1Node.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(Level1Node)
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
