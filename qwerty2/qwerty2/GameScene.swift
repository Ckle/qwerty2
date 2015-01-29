//
//  GameScene.swift
//  qwerty2
//
//  Created by Chris Lee on 2014-12-19.
//  Copyright (c) 2014 Coffee Digital. All rights reserved.
//


import UIKit
import Foundation
import SpriteKit

class GameScene: SKScene, UITextViewDelegate {
    
    // --------------------------- GAME VARIABLEs
    
    // UITextViews
    var textDisplay = UITextView() // Hidden textView just to detect typing
    var textShown1 = CustomTextView()
    var textShown2 = CustomTextView()
    var textShown3 = CustomTextView()
    var textShown4 = CustomTextView()
    var textShown5 = CustomTextView()
    var textShown6 = CustomTextView()
    var textShown7 = CustomTextView()
    var textShown8 = CustomTextView()
    var textShown9 = CustomTextView()
    var paragraphStrings: [NSMutableAttributedString] = [] // An array that all the other AttributedStrings are attached to
    var paragraphs: [CustomTextView] = [] // An array that all the other textViews are added to
    var currentString = Int() // Integer that points to item in AS array
    var currentParagraph = Int() // The integer that points to which item in the paragraph array
    var textForPlayer = NSMutableAttributedString()
    var textViewForPlayer = CustomTextView()
    var totalCharsShown = Int()
    var rangeOfText = Int() // For the addToRange function which moves the selected character of the visible UITextView
    var paragraphCount = 8
    
    // Timer Bar
    var timerBar = SKSpriteNode()
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var gameTime = CGFloat()
    
    public var currentLevel: Int = 1

    // Transition Scene Button Variable Declaration
    let titleScreenNode = SKSpriteNode(color: SKColor .greenColor(), size: CGSizeMake(150.0, 100.0))
    
    // Characters Typed or Required to be typed
    var charTyped = String()
    var charRequired = String()

    // Score Counter
    var correctCharsTyped = SKLabelNode()
    var mistakesMadeLabel = SKLabelNode()
    var mistakesMade = Int()
    
    // Game Layers
    let gameLayer = SKNode()
    let gameObjects = SKNode()
    let gameMenu = SKNode()
    let gameOverLayer = SKNode()
    
    // Paragraph Phrases
    var attrString1 = NSMutableAttributedString()
    var attrString2 = NSMutableAttributedString()
    var attrString3 = NSMutableAttributedString()
    var attrString4 = NSMutableAttributedString()
    var attrString5 = NSMutableAttributedString()
    var attrString6 = NSMutableAttributedString()
    var attrString7 = NSMutableAttributedString()
    var attrString8 = NSMutableAttributedString()
    var attrString9 = NSMutableAttributedString()
    
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
        let textFont = [NSFontAttributeName: UIFont(name: "Georgia", size: 20.0) ?? UIFont.systemFontOfSize(18.0)]
        let italFont = [NSFontAttributeName: UIFont(name: "Georgia-Italic", size: 40.0) ?? UIFont.systemFontOfSize(18.0)]
       
        // Define string attributes
        
        // Create locally formatted strings
        attrString1 = NSMutableAttributedString(string: "My name is Dug.", attributes: textFont)
        attrString2 = NSMutableAttributedString(string: "My male man, who has the name Jake", attributes: textFont)
        attrString3 = NSMutableAttributedString(string: "recently started meeting frequently", attributes: textFont)
        attrString4 = NSMutableAttributedString(string: "with a female man.", attributes: textFont)
        attrString5 = NSMutableAttributedString(string: "I know it is a female man", attributes: textFont)
        attrString6 = NSMutableAttributedString(string: "because of her fur.", attributes: textFont)
        attrString7 = NSMutableAttributedString(string: "It is long like an English Sheepdog", attributes: textFont)
        attrString8 = NSMutableAttributedString(string: "except that an English Sheepdog is beautiful. ", attributes: textFont)
        
        // Make the paragraph the default colour
        attrString1.addAttribute(
            NSForegroundColorAttributeName,
            value: UIColor.blackColor(),
            range: NSRange(location: 0, length: attrString1.length))
        attrString1.addAttribute(
            NSUnderlineStyleAttributeName,
            value: NSUnderlineStyle.StyleDouble.rawValue,
            range: NSMakeRange(0, 1))
        
        // Create UITextView
        textDisplay = UITextView(frame: CGRect(x: 0, y: 20, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-60))
    
        textShown1 = CustomTextView(frame: CGRect(x: 0, y: 200, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-400))
        textShown2 = CustomTextView(frame: CGRect(x: 0, y: 240, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-400))
        textShown3 = CustomTextView(frame: CGRect(x: 0, y: 280, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-400))
        textShown4 = CustomTextView(frame: CGRect(x: 0, y: 320, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-400))
        textShown5 = CustomTextView(frame: CGRect(x: 0, y: 360, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-400))
        textShown6 = CustomTextView(frame: CGRect(x: 0, y: 400, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-400))
        textShown7 = CustomTextView(frame: CGRect(x: 0, y: 440, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-400))
        textShown8 = CustomTextView(frame: CGRect(x: 0, y: 480, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-400))
        textShown1.backgroundColor = UIColor.clearColor()
        textShown2.backgroundColor = UIColor.clearColor()
        textShown3.backgroundColor = UIColor.clearColor()
        textShown4.backgroundColor = UIColor.clearColor()
        textShown5.backgroundColor = UIColor.clearColor()
        textShown6.backgroundColor = UIColor.clearColor()
        textShown7.backgroundColor = UIColor.clearColor()
        textShown8.backgroundColor = UIColor.clearColor()
        
        // Bring Up Keyboard Immediately
        textDisplay.autocorrectionType = UITextAutocorrectionType.No
        textDisplay.becomeFirstResponder()
        textDisplay.keyboardType = UIKeyboardType.Default
        
        // Add string to UITextView
        textDisplay.attributedText = attrString1
        
        textShown1.attributedText = attrString1
        textShown2.attributedText = attrString2
        textShown3.attributedText = attrString3
        textShown4.attributedText = attrString4
        textShown5.attributedText = attrString5
        textShown6.attributedText = attrString6
        textShown7.attributedText = attrString7
        textShown8.attributedText = attrString8
        
        // Visibility of the two UITextViews
        textDisplay.hidden = true
        textShown1.hidden = false
        textShown1.editable = false
        
        // Add UITextView to main view
        self.view?.addSubview(textDisplay)
        self.view?.addSubview(textShown1)
        self.view?.addSubview(textShown2)
        self.view?.addSubview(textShown3)
        self.view?.addSubview(textShown4)
        self.view?.addSubview(textShown5)
        self.view?.addSubview(textShown6)
        self.view?.addSubview(textShown7)
        self.view?.addSubview(textShown8)
        
        // Creating Arrays of TextViews and AttributedStrings to be used in cursor mvmt
        paragraphs = [textShown1, textShown2, textShown3]
        currentParagraph = 0
        paragraphStrings = [attrString1, attrString2, attrString3]
        currentString = 0
        textViewForPlayer = paragraphs[0]
        textForPlayer = paragraphStrings[0]
        
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
        attrString1.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSRange(location: 0, length: attrString1.length))
        attrString1.addAttribute(NSBackgroundColorAttributeName, value: UIColor.clearColor(), range: NSRange(location: 0, length: attrString1.length))
        
        scene?.userInteractionEnabled = true
    }
    
    // Updates Timer Bar
    func updateTime() {
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime = currentTime - startTime
        var seconds = Double(Double(gameTime) - elapsedTime)
        
        if seconds > 0 {
            
            elapsedTime -= NSTimeInterval(seconds)
            println("\(Double(seconds))")
            
        } else {
            
            timer.invalidate()
            gameEnded(didWin: false)
        }
        
        // For Bronze/silver colors of TimerBar
        var sceneHalfSize = self.frame.width / 2
        
        if timerBar.size.width < sceneHalfSize / 2  {
            
            timerBar.color = UIColor.redColor()
            
        } else if timerBar.size.width < sceneHalfSize {
            
            timerBar.color = UIColor.orangeColor()
        }

        // **Keep for learning purposes**
        // var secondsLeft = CGFloat(seconds / gameTime)
        // self.timerBar.size.width = ((self.size.width) * secondsLeft)
        // self.timerBar.size.width = SKAction.scaleXTo(secondsLeft, duration: 0.2)
    }
    
    // Handles Game Over Functions
    func gameEnded(#didWin: Bool) {
        
        timer.invalidate()
        
        if didWin {
            
            println("WIN")
            let scene = LevelFinishedScene(size: self.size)
            self.view?.presentScene(scene)

        } else {
            
            println("FAIL")
            let scene = GameOverScene(size: self.size)
            self.view?.presentScene(scene)

        }
    }

    func addToRange() {
        
            // increment the range of textShown so that the marker will move fwd
            rangeOfText++

    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        // WHAT IS HAPPENING HERE:
        // Tracking an incrementing string character in the chosen TextView
        // Changing the attributes of an attributed string in the chosen TextView
        
        var charTyped = text // Character that was typed
        totalCharsShown = (countElements(textViewForPlayer.text)) // Used to detect win condition
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
                start: advance(textViewForPlayer.text.startIndex, rangeOfText),
                end: advance(textViewForPlayer.text.startIndex, rangeOfText + 1))
            charRequired = textViewForPlayer.text.substringWithRange(rangeOfTextShown)
            
            // Creates the Underline. Removes first underline
            textForPlayer.addAttribute(
                NSUnderlineStyleAttributeName,
                value: NSUnderlineStyle.StyleDouble.rawValue,
                range: NSMakeRange((rangeOfText + 1), 1))
            textForPlayer.removeAttribute(
                NSUnderlineStyleAttributeName,
                range: NSMakeRange((rangeOfText), 1))
            
            // Logic for matching character typed to character required
            if charTyped == charRequired {
                
                println("CORRECT")
                // Changes the color of the text if correct letter was typed
                textForPlayer.addAttribute(
                    NSForegroundColorAttributeName,
                    value: UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0),
                    range: nsRangeOfTextShown)
                // have to make sure to add the attributed text string to the UITextView or it won't show
                textViewForPlayer.attributedText = textForPlayer
                
            } else if charTyped != charRequired {
                
                println("FALSE")
                ++mistakesMade
                // Changes the color of the text if incorrect letter was typed
                textForPlayer.addAttribute(
                    NSForegroundColorAttributeName,
                    value: UIColor(red: 209/255, green: 23/255, blue: 23/255, alpha: 1.0),
                    range: nsRangeOfTextShown)
                textForPlayer.addAttribute(
                    NSBackgroundColorAttributeName,
                    value: UIColor(red: 201/255, green: 121/255, blue: 129/255, alpha: 0.5),
                    range: nsRangeOfTextShown)
                textViewForPlayer.attributedText = textForPlayer
                
            } else {
                
                textForPlayer.addAttribute(
                    NSForegroundColorAttributeName,
                    value: UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0),
                    range: nsRangeOfTextShown)
            }

            
        } else {
            
            var rangeOfTextShown: Range = Range(
                start: advance(textViewForPlayer.text.startIndex, rangeOfText),
                end: advance(textViewForPlayer.text.startIndex, rangeOfText + 1))
            charRequired = textViewForPlayer.text.substringWithRange(rangeOfTextShown)
            
            // This if statement will increment the current TextView selected for identifying characters required/shown,
            // along with the current attributed string that needs to now have its new attributes changed.
            if currentParagraph < paragraphs.count {
            
                textViewForPlayer = paragraphs[++currentParagraph]
                textForPlayer = paragraphStrings[++currentString]
                println("\(textForPlayer)")
                println("\(currentString) CURRENT STRING")
                rangeOfText = 0

            } else if currentParagraph == paragraphs.count {
                
                gameEnded(didWin: true)
            }
        }
        
        println("Character Typed = \(charTyped)")
        println("Character Required = \(charRequired)")
        println("Range of Text = \(rangeOfText)")
        println("Total Characters = \(totalCharsShown)")
                
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
            
            gameEnded(didWin: false)
        }

        return true
    }
    
//    func textViewDidChange(textView: UITextView) {
//        
//        for (component: String) in textShown.text.componentsSeparatedByString("\n") {
//            var mutableComponent: NSMutableString = component.mutableCopy() as NSMutableString
//
//        }
//    }
    
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
        textShown1.removeFromSuperview()
        textShown2.removeFromSuperview()
        textShown3.removeFromSuperview()
        textShown4.removeFromSuperview()
        textShown5.removeFromSuperview()
        textShown6.removeFromSuperview()
        textShown7.removeFromSuperview()
        textShown8.removeFromSuperview()

    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.mistakesMadeLabel.text = "\(mistakesMade)"
        
    }
}

// To make sure the textview cannot be tapped on.
class CustomTextView: UITextView {
    
    override func canBecomeFirstResponder() -> Bool {

        return false
    }
}


