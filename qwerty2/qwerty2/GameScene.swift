//
//  GameScene.swift
//  qwerty2
//
//  Created by Chris Lee on 2014-12-19.
//  Copyright (c) 2014 Coffee Digital. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene {
    
    var timerBar = SKSpriteNode()
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var gameTime: Double = 10.0
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red: 81/255, green: 150/255, blue: 111/255, alpha: 1.0)
        
        self.timerBar.position = CGPoint(x: 0, y: (CGRectGetMaxY(self.frame)))
        self.timerBar.color = SKColor .blueColor()
        self.timerBar.anchorPoint = CGPoint(x: 0,y: 1)
        self.timerBar.size.width = (self.size.width)
        self.timerBar.size.height = 40
        self.addChild(timerBar)
        
        startGame()
    }
    
    func startGame() {
        
        let aSelector : Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        
    }
    
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime = currentTime - startTime
        var seconds = Double(gameTime - elapsedTime)
        if seconds > 0 {
            elapsedTime -= NSTimeInterval(seconds)
            println("\(Double(seconds))")
        } else {
            timer.invalidate()
        
        var secondsLeft = CGFloat(seconds / gameTime)
        self.timerBar.size.width = ((self.size.width) * secondsLeft)
        // self.timerBar.size.width = SKAction.scaleXTo(secondsLeft, duration: 0.2)

    }
}
     override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}


