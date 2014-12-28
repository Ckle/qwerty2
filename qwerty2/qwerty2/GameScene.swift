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
    
    // Timer Bar
    var timerBar = SKSpriteNode()
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var gameTime: Double = 10.0
    
    // Type
    let textFont = [NSFontAttributeName: UIFont(name: "Georgia", size: 18.0) ?? UIFont.systemFontOfSize(18.0)]
    let italFont = [NSFontAttributeName: UIFont(name: "Georgia-Italic", size: 18.0) ?? UIFont.systemFontOfSize(18.0)]
    
    // Transition Scene Button Variable Declaration
    let titleScreenNode = SKSpriteNode(color: SKColor .greenColor(), size: CGSizeMake(150.0, 100.0))
    
    override func didMoveToView(view: SKView) {
        
        // SKView Properties
        self.backgroundColor = UIColor(red: 81/255, green: 150/255, blue: 111/255, alpha: 1.0)
        
        // Timer Bar Initialize
        self.timerBar.position = CGPoint(x: 0, y: (CGRectGetMaxY(self.frame)))
        self.timerBar.color = SKColor .blueColor()
        self.timerBar.anchorPoint = CGPoint(x: 0,y: 1)
        self.timerBar.size.width = (self.size.width)
        self.timerBar.size.height = 40
        self.addChild(timerBar)
        
        startGame()
        self.timerBar.runAction(SKAction.scaleXTo(0, duration: gameTime))
        
        // Transition Scene button
        self.titleScreenNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame))
        self.addChild(titleScreenNode)
        self.backgroundColor = UIColor(red: 81/255, green: 150/255, blue: 111/255, alpha: 1.0)
        
        // Type
        // Define string attributes
        // Create a string that will be our paragraph
        let para = NSMutableAttributedString()
        
        // Create locally formatted strings
        let attrString1 = NSAttributedString(string: "Hello Swift! This is a tutorial looking at ", attributes:textFont)
        let attrString2 = NSAttributedString(string: "attributed", attributes:italFont)
        let attrString3 = NSAttributedString(string: " strings.", attributes:textFont)
        
        // Add locally formatted strings to paragraph
        para.appendAttributedString(attrString1)
        para.appendAttributedString(attrString2)
        para.appendAttributedString(attrString3)
        
        // Define paragraph styling
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.firstLineHeadIndent = 15.0
        paraStyle.paragraphSpacingBefore = 10.0
        
        // Apply paragraph styles to paragraph
        para.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSRange(location: 0,length: para.length))
        
        // Create UITextView
        let textBox = UITextView(frame: CGRect(x: 0, y: 20, width: CGRectGetWidth(self.frame), height: CGRectGetWidth(self.frame)-20))
        
        // Add string to UITextView
        textBox.attributedText = para
        
        // Add UITextView to main view
        self.view?.addSubview(textBox)
        
    }
    
    func startGame() {
        
        let aSelector : Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
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
        }
        // **Keep for learning purposes**
        // var secondsLeft = CGFloat(seconds / gameTime)
        // self.timerBar.size.width = ((self.size.width) * secondsLeft)
        // self.timerBar.size.width = SKAction.scaleXTo(secondsLeft, duration: 0.2)
    
}
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if self.nodeAtPoint(location) == self.titleScreenNode {
                var scene = TitleScene(size: self.size)
                let skView = self.view as SKView!
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .ResizeFill
                scene.size = skView.bounds.size
                skView.presentScene(scene)
            }
        }
    }

     override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
    
    override func willMoveFromView(view: SKView) {
        super.willMoveFromView(view)
        self.view?.removeFromSuperview(textBox)
    }
}






