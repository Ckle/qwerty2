//
//  GameScene.swift
//  qwerty2
//
//  Created by Chris Lee on 2014-12-19.
//  Copyright (c) 2014 Coffee Digital. All rights reserved.
//

import SpriteKit
import UIKit
import Foundation

class GameScene: SKScene, UITextViewDelegate {
    
    var textDisplay = UITextView()
    var textShown = UITextView()
    var rangeOfTextShown = 0
    // Timer Bar
    var timerBar = SKSpriteNode()
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var gameTime: Double = 10.0

    // Transition Scene Button Variable Declaration
    let titleScreenNode = SKSpriteNode(color: SKColor .greenColor(), size: CGSizeMake(150.0, 100.0))
    
    var charTyped = String()
    var charRequired = String()
    // Text Display
    // var lvl1 = Levels()

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
        
        addUIElements()
        
    }
    
    func addUIElements() {
       
        // Type
        let textFont = [NSFontAttributeName: UIFont(name: "Georgia", size: 18.0) ?? UIFont.systemFontOfSize(18.0)]
        let italFont = [NSFontAttributeName: UIFont(name: "Georgia-Italic", size: 18.0) ?? UIFont.systemFontOfSize(18.0)]
       
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
        para.addAttribute(NSFontAttributeName, value: UIFont(name: "Georgia", size: 18.0)!, range: NSRange(location: 7, length: 5))
        
        // Define paragraph styling
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.firstLineHeadIndent = 15.0
        paraStyle.paragraphSpacingBefore = 10.0
        
        // Apply paragraph styles to paragraph
        para.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSRange(location: 0,length: para.length))
        
        // Create UITextView
        textDisplay = UITextView(frame: CGRect(x: 0, y: 20, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-60))
        textShown = UITextView(frame: CGRect(x: 0, y: 20, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-60))
        
        // Bring Up Keyboard Immediately
        textDisplay.autocorrectionType = UITextAutocorrectionType.No
        textDisplay.becomeFirstResponder()
        // textDisplay.hidden = true
        textDisplay.keyboardType = UIKeyboardType.EmailAddress
        
        // Add string to UITextView
        textDisplay.attributedText = para
        textShown.attributedText = para
        
        textDisplay.hidden = true
        // Add UITextView to main view
        self.view?.addSubview(textDisplay)
        self.view?.addSubview(textShown)
        
        // Assign the UITextView's(textDisplay's) delegate to be the class we're in.
        textDisplay.delegate = self

    }
    
    func startGame() {
        
        let aSelector: Selector = "updateTime"
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

    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        var charTyped = text
        println("\(charTyped)")
        
        if charTyped == charRequired {
            println("WHOA")
        }
        // ** This was supposed to identify the last character typed. the above does that much quicker.
        //var totalCharsTyped = (countElements(textDisplay.text))
        //var lastCharTypedIndex = totalCharsTyped - 1
        //var lastCharTyped = textDisplay.text.substringFromIndex(advance(textDisplay.text.startIndex,(lastCharTypedIndex)))
        //println("\(lastCharTyped)")
        
        func addToRange() {
            ++rangeOfTextShown
        }
        var rangeOfTextDisplay = (Range(start: textDisplay.text.startIndex, end: textDisplay.text.endIndex))
        var testRange = textDisplay.text.substringWithRange(rangeOfTextDisplay)
        println("TRUE + \(testRange)")
        
        
        return true
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
    
    override func willMoveFromView(view: SKView) {
        println("Removed UIElement from Scene")
        textDisplay.removeFromSuperview()
        // textDisplay.hidden = true
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}





