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
    var totalCharsShown = Int()
    var rangeOfText = Int() // For the addToRange function which moves the selected character of the visible UITextView
    
    // Timer Bar
    var timerBar = SKSpriteNode()
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var gameTime = CGFloat()

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
    
    var gameOver = GameOverScene()
    
    // Paragraph Phrases
    var attrString1 = NSAttributedString()
    var attrString2 = NSAttributedString()
    var attrString3 = NSAttributedString()
    var attrString4 = NSAttributedString()
    var attrString5 = NSAttributedString()
    var attrString6 = NSAttributedString()
    
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
        let textFont = [NSFontAttributeName: UIFont(name: "Georgia", size: 40.0) ?? UIFont.systemFontOfSize(18.0)]
        let italFont = [NSFontAttributeName: UIFont(name: "Georgia-Italic", size: 40.0) ?? UIFont.systemFontOfSize(18.0)]
       
        // Define string attributes
        
        // Create locally formatted strings
        attrString1 = NSAttributedString(string: "My name is Dug. My male man, who has the name Jake recently started meeting frequently with a female man. It is long like an English Sheepdog, except that an English Sheepdog is beautiful. ", attributes:textFont)
        
        // Add locally formatted strings to paragraph
        para.appendAttributedString(attrString1)
    
        // Define paragraph styling
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.paragraphSpacingBefore = 10.0
        // paraStyle.lineSpacing = 100.0
        
        // Apply paragraph styles to paragraph
        para.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSRange(location: 0,length: para.length))
        
        // Make the paragraph the default colour
        para.addAttribute(
            NSForegroundColorAttributeName,
            value: UIColor.blackColor(),
            range: NSRange(location: 0, length: para.length))
        para.addAttribute(
            NSUnderlineStyleAttributeName,
            value: NSUnderlineStyle.StyleDouble.rawValue,
            range: NSMakeRange(0, 1))
        
        // Create UITextView
        textDisplay = UITextView(frame: CGRect(x: 0, y: 20, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-60))
        textShown = UITextView(frame: CGRect(x: 0, y: 200, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-400))
        textShown.backgroundColor = UIColor.clearColor()
        
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
        gameTime = CGFloat((arc4random() % (18-15+1)) + 15)
        let aSelector: Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        self.timerBar.size.width = (self.size.width)
        self.timerBar.runAction(SKAction.scaleXTo(0, duration: Double(gameTime)))
        
        // Sets the first character required to 0
        rangeOfText =  0
        
        // Sets mistakes to 0
        mistakesMade = 0
        
        // Reset Paragraph to default color
        para.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSRange(location: 0, length: para.length))
        para.addAttribute(NSBackgroundColorAttributeName, value: UIColor.clearColor(), range: NSRange(location: 0, length: para.length))
        textShown.attributedText = para
        
        scene?.userInteractionEnabled = true
    }
    
    func updateTime() {
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime = currentTime - startTime
        var seconds = Double(Double(gameTime) - elapsedTime)
        
        if seconds > 0 {
            
            elapsedTime -= NSTimeInterval(seconds)
            println("\(Double(seconds))")
            
        } else {
            
            timer.invalidate()
            levelFail()
        }

        // **Keep for learning purposes**
        // var secondsLeft = CGFloat(seconds / gameTime)
        // self.timerBar.size.width = ((self.size.width) * secondsLeft)
        // self.timerBar.size.width = SKAction.scaleXTo(secondsLeft, duration: 0.2)
    }
    
    func levelFail() {
        
        println("FAIL")
        var scene = GameOverScene(size: self.size)
        let skView = self.view as SKView!
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        scene.size = skView.bounds.size
        skView.presentScene(scene)
        timer.invalidate()
        gameOver.didLose()
    }
    
    func levelWin() {
        
        println("WIN")
        var scene = GameOverScene(size: self.size)
        let skView = self.view as SKView!
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        scene.size = skView.bounds.size
        skView.presentScene(scene)
        timer.invalidate()
        gameOver.didWin()
    }


    func addToRange() {
        
            // increment the range of textShown so that the marker will move fwd
            rangeOfText++

    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        var charTyped = text // Character that was typed
        totalCharsShown = (countElements(textShown.text)) // Used to detect win condition
        var charRequired = String() // Character that needs to be typed next
        
        // Since changing the attributed String range REQUIRES an NSRange (rangeOfTextShown is a Range, not NSRange - the testRange String is converted to NSString, so that we can make a NSRange of out it)
        let nsRangeOfTextShown = NSMakeRange(rangeOfText, 1)
        // let nsText = textShown.text as NSString
        // let attributedString = NSMutableAttributedString(string: nsText)
        // Above not needed because i am using para as the attributed string
       
        // logic for underline changing along with incrementing text range to determine character required
        if totalCharsShown > (rangeOfText + 1) {
            
            // Finding the current selection of character that needs to be typed from the visible UITextView
            var rangeOfTextShown: Range = Range(
                start: advance(textShown.text.startIndex, rangeOfText),
                end: advance(textShown.text.startIndex, rangeOfText + 1))
            charRequired = textShown.text.substringWithRange(rangeOfTextShown)
            
            // Creates the Underline. Removes first underline
            para.addAttribute(
                NSUnderlineStyleAttributeName,
                value: NSUnderlineStyle.StyleDouble.rawValue,
                range: NSMakeRange((rangeOfText + 1), 1))
            para.removeAttribute(
                NSUnderlineStyleAttributeName,
                range: NSMakeRange((rangeOfText), 1))
            
            // Scroll down when out of view
          //  textShown.scrollRangeToVisible(NSMakeRange((rangeOfText + 1), 1))
        
        } else {
            
            var rangeOfTextShown: Range = Range(
                start: advance(textShown.text.startIndex, rangeOfText),
                end: advance(textShown.text.startIndex, rangeOfText + 1))
            charRequired = textShown.text.substringWithRange(rangeOfTextShown)
            
            levelWin()
        }
        
        println("Character Typed = \(charTyped)")
        println("Character Required = \(charRequired)")
        println("Range of Text = \(rangeOfText)")
        println("Total Characters = \(totalCharsShown)")
        
        
        // Logic for matching character typed to character required
        if charTyped == charRequired {
           
            println("CORRECT")
            // Changes the color of the text if correct letter was typed
            para.addAttribute(
                NSForegroundColorAttributeName,
                value: UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0),
                range: nsRangeOfTextShown)
            // have to make sure to add the attributed text string to the UITextView or it won't show
            textShown.attributedText = para
        
        } else if charTyped != charRequired {
            
            println("FALSE")
            ++mistakesMade
            // Changes the color of the text if incorrect letter was typed
            para.addAttribute(
                NSForegroundColorAttributeName,
                value: UIColor(red: 209/255, green: 23/255, blue: 23/255, alpha: 1.0),
                range: nsRangeOfTextShown)
            para.addAttribute(
                NSBackgroundColorAttributeName,
                value: UIColor(red: 201/255, green: 121/255, blue: 129/255, alpha: 0.5),
                range: nsRangeOfTextShown)
            textShown.attributedText = para
            
        } else {
            
            para.addAttribute(
                NSForegroundColorAttributeName,
                value: UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0),
                range: nsRangeOfTextShown)
        }
        
        // ** This was supposed to identify the last character typed. the above does that much quicker.
        //var totalCharsTyped = (countElements(textDisplay.text))
        //var lastCharTypedIndex = totalCharsTyped - 1
        //var lastCharTyped = textDisplay.text.substringFromIndex(advance(textDisplay.text.startIndex,(lastCharTypedIndex)))
        //println("\(lastCharTyped)")
        
        if rangeOfText < (totalCharsShown - 1) {
        
            // Moves the marker forward to the next required character in visible UITextView
            addToRange()
        }
        
        if mistakesMade == 3 {
            
            levelFail()
        }
        
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



