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
    var rangeOfText = -1 // For the addToRange function which moves the selected character of the visible UITextView
    
    // Timer Bar
    var timerBar = SKSpriteNode()
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var gameTime: Double = 10.0

    // Transition Scene Button Variable Declaration
    let titleScreenNode = SKSpriteNode(color: SKColor .greenColor(), size: CGSizeMake(150.0, 100.0))
    
    // Characters Typed or Required to be typed
    var charTyped = String()
    var charRequired = String()
    
    // Create a string that will be our visible UITextView Paragraph
    let para = NSMutableAttributedString()
    
    // Text Display
    // var lvl1 = Levels()

    // Score Counter
    var correctCharsTyped = SKLabelNode()
    var mistakesMadeLabel = SKLabelNode()
    var mistakesMade = Int()
    
    override func didMoveToView(view: SKView) {
        
        // SKView Properties
        self.backgroundColor = UIColor(red: 242/255, green: 211/255, blue: 157/255, alpha: 1.0)
        
        // Timer Bar Initialize
        self.timerBar.position = CGPoint(x: 0, y: (CGRectGetMaxY(self.frame)))
        self.timerBar.color = SKColor(red: 255/255, green: 251/255, blue: 207/255, alpha: 1.0)
        self.timerBar.anchorPoint = CGPoint(x: 0,y: 1)
        self.timerBar.size.width = (self.size.width)
        self.timerBar.size.height = 40
        self.timerBar.zPosition = 5
        self.addChild(timerBar)
        
        startGame()
        self.timerBar.runAction(SKAction.scaleXTo(0, duration: gameTime))
        
        // Transition Scene button
        self.titleScreenNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame))
        self.addChild(titleScreenNode)
        
        // Mistake Counter
        self.mistakesMadeLabel.position = CGPoint(x: 50, y: (CGRectGetMaxY(self.frame))-80)
        self.mistakesMadeLabel.fontSize = 40.00
        self.mistakesMadeLabel.fontName = "Helvetica Neue"
        self.mistakesMadeLabel.fontColor = SKColor.blackColor()
        self.addChild(mistakesMadeLabel)
        
        
        addUIElements()
        
    }
    
    func addUIElements() {
       
        // Type
        let textFont = [NSFontAttributeName: UIFont(name: "Georgia", size: 18.0) ?? UIFont.systemFontOfSize(18.0)]
        let italFont = [NSFontAttributeName: UIFont(name: "Georgia-Italic", size: 18.0) ?? UIFont.systemFontOfSize(18.0)]
       
        // Define string attributes
        
        // Create locally formatted strings
        let attrString1 = NSAttributedString(string: "Hello Swift!", attributes:textFont)
        let attrString2 = NSAttributedString(string: "attributed", attributes:italFont)
        let attrString3 = NSAttributedString(string: " strings.", attributes:textFont)
        
        // Add locally formatted strings to paragraph
        para.appendAttributedString(attrString1)
        para.appendAttributedString(attrString2)
        para.appendAttributedString(attrString3)
        para.addAttribute(NSFontAttributeName, value: UIFont(name: "Georgia", size: 18.0)!, range: NSRange(location: 7, length: 5))
       // para.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location: 7, length: 5))
        
        // Define paragraph styling
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.firstLineHeadIndent = 15.0
        paraStyle.paragraphSpacingBefore = 10.0
        
        // Apply paragraph styles to paragraph
        para.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSRange(location: 0,length: para.length))
        
        // Create UITextView
        textDisplay = UITextView(frame: CGRect(x: 0, y: 20, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-60))
        textShown = UITextView(frame: CGRect(x: 0, y: 100, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-200))
        
        // Bring Up Keyboard Immediately
        textDisplay.autocorrectionType = UITextAutocorrectionType.No
        textDisplay.becomeFirstResponder()
        // textDisplay.hidden = true
        textDisplay.keyboardType = UIKeyboardType.EmailAddress
        
        // Add string to UITextView
        textDisplay.attributedText = para
        textShown.attributedText = para //SOMETHING HERE IS NOT ALLOWING PARA TO CHANGE COLORS AFTER
        
        // Visibility of the two UITextViews
        textDisplay.hidden = true
        textShown.hidden = false
        textShown.editable = false
        
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

    func addToRange() {
        ++rangeOfText
        // increment the range of textShown so that the marker will move fwd
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        var charTyped = text
        println("Character Typed = \(charTyped)")
    
        addToRange() // Moves the marker forward to the next required character in visible UITextView
        
        // Finding the current selection of character that needs to be typed from the visible UITextView
        var rangeOfTextShown = Range(start: advance(textShown.text.startIndex, rangeOfText), end: advance(textShown.text.startIndex, rangeOfText + 1))
        var testRange = textShown.text.substringWithRange(rangeOfTextShown)
        
        // Since changing the attributed String range REQUIRES an NSRange (rangeOfTextShown is a Range, not NSRange - the testRange String is converted to NSString, so that we can make a NSRange of out it)
        let nsText = testRange as NSString
        let nsRangeOfTextShown = NSMakeRange(0, nsText.length)
        let attributedString = NSMutableAttributedString(string: nsText)
        
        charRequired = testRange
        println("Character Required = \(testRange)")
        
        if charTyped == charRequired {
            println("CORRECT")
            para.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: nsRangeOfTextShown)
            textShown.attributedText = para
        } else {
            println("FALSE")
            ++mistakesMade
        }
        
        // ** This was supposed to identify the last character typed. the above does that much quicker.
        //var totalCharsTyped = (countElements(textDisplay.text))
        //var lastCharTypedIndex = totalCharsTyped - 1
        //var lastCharTyped = textDisplay.text.substringFromIndex(advance(textDisplay.text.startIndex,(lastCharTypedIndex)))
        //println("\(lastCharTyped)")
        
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
        textShown.removeFromSuperview()
        // textDisplay.hidden = true
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.mistakesMadeLabel.text = "\(mistakesMade)"
    }
}



