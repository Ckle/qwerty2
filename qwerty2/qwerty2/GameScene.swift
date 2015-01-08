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
    
    // --------------------------- GAME VARIABLEs
    
    // UITextViews
    var textDisplay = UITextView()
    var textShown = UITextView()
    var rangeOfText = Int() // For the addToRange function which moves the selected character of the visible UITextView
    
    // Timer Bar
    var timerBar = SKSpriteNode()
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var gameTime: Double = 30.0

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
    
    // Game Layers
    let gameLayer = SKNode()
    let gameObjects = SKNode()
    let gameMenu = SKNode()
    let gameOverLayer = SKNode()
    
    
    // -------------------------- INITs
    
    override init(size: CGSize) {
    super.init(size: size)
        
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
        
        // Transition Scene button
        self.titleScreenNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame))
        self.addChild(titleScreenNode)
        
        // Mistake Counter
        self.mistakesMadeLabel.position = CGPoint(x: 50, y: (CGRectGetMaxY(self.frame))-80)
        self.mistakesMadeLabel.zPosition = 100
        self.mistakesMadeLabel.fontSize = 40.00
        self.mistakesMadeLabel.fontName = "Helvetica Neue"
        self.mistakesMadeLabel.fontColor = SKColor.blackColor()
        self.addChild(mistakesMadeLabel)
        
        // Layers
        gameLayer.hidden = true
        addChild(gameLayer)
        
        // Game Over Screen
        gameOverLayer.zPosition = 100
        gameOverLayer.alpha = 0
        gameLayer.addChild(gameOverLayer)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // --------------------------- GAME METHODS
    
    override func didMoveToView(view: SKView) {
        
        // Add UITextViews
        addUIElements()
        
        startGame()
        
    }
    
    func addUIElements() {
       
        // Type
        let textFont = [NSFontAttributeName: UIFont(name: "Georgia", size: 60.0) ?? UIFont.systemFontOfSize(18.0)]
        let italFont = [NSFontAttributeName: UIFont(name: "Georgia-Italic", size: 18.0) ?? UIFont.systemFontOfSize(18.0)]
       
        // Define string attributes
        
        // Create locally formatted strings
        let attrString1 = NSAttributedString(string: "Hello Swift! THERE IS lots of text here too long for the UITextView HAHAH AHAHA Hahahahahah ahahaha hahaha", attributes:textFont)
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
        
        // Make the paragraph the default colour
        para.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSRange(location: 0, length: para.length))
        
        // Create UITextView
        textDisplay = UITextView(frame: CGRect(x: 0, y: 20, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-60))
        textShown = UITextView(frame: CGRect(x: 0, y: 100, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-200))
        textShown.backgroundColor = UIColor(netHex:0x9C5960)
        
        // Bring Up Keyboard Immediately
        textDisplay.autocorrectionType = UITextAutocorrectionType.No
        textDisplay.becomeFirstResponder()
        textDisplay.keyboardType = UIKeyboardType.Default
        
        // Add string to UITextView
        textDisplay.attributedText = para
        textShown.attributedText = para
        
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
        
        // Starts Timer
        let aSelector: Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        self.timerBar.size.width = (self.size.width)
        self.timerBar.runAction(SKAction.scaleXTo(0, duration: gameTime))
        
        // Sets the first character required to 0
        rangeOfText = -1
        
        // Sets mistakes to 0
        mistakesMade = 0
        
        // Reset Paragraph to default color
        para.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSRange(location: 0, length: para.length))
        para.addAttribute(NSBackgroundColorAttributeName, value: UIColor.clearColor(), range: NSRange(location: 0, length: para.length))
        textShown.attributedText = para
        
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
    
        // Moves the marker forward to the next required character in visible UITextView
        addToRange()
        
        // Finding the current selection of character that needs to be typed from the visible UITextView
        var rangeOfTextShown = Range(start: advance(textShown.text.startIndex, rangeOfText), end: advance(textShown.text.startIndex, rangeOfText + 1))
        var testRange = textShown.text.substringWithRange(rangeOfTextShown)
        charRequired = testRange
        println("Character Required = \(testRange)")
        
        // Since changing the attributed String range REQUIRES an NSRange (rangeOfTextShown is a Range, not NSRange - the testRange String is converted to NSString, so that we can make a NSRange of out it)
        let nsText = textShown.text as NSString
        let nsRangeOfTextShown = NSMakeRange(rangeOfText, 1)
        // let attributedString = NSMutableAttributedString(string: nsText) 
        // Above not needed because i am using para as the attributed string
        
        if charTyped == charRequired {
            println("CORRECT")
            para.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0), range: nsRangeOfTextShown)
            textShown.attributedText = para
            // have to make sure to add the attributed text string to the UITextView or it won't show
        } else {
            println("FALSE")
            ++mistakesMade
            para.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 209/255, green: 23/255, blue: 23/255, alpha: 1.0), range: nsRangeOfTextShown)
            para.addAttribute(NSBackgroundColorAttributeName, value: UIColor(red: 201/255, green: 121/255, blue: 129/255, alpha: 0.5), range: nsRangeOfTextShown)
            textShown.attributedText = para
        }
        
        if mistakesMade == 3 || gameTime == 0 {
            //GameViewController().gameOverPanel.image = UIImage(named: "Spaceship")
            GameViewController().showGameOver()
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
        
        // Remove these UITextViews from the SKView
        textDisplay.removeFromSuperview()
        textShown.removeFromSuperview()

    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.mistakesMadeLabel.text = "\(mistakesMade)"
    }
}



