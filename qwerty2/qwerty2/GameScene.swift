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

let π = M_PI

public class GameScene: SKScene, UITextViewDelegate {
    
    // --------------------------- GAME VARIABLEs
    
    // UITextViews
    var textDisplay = UITextView() // Hidden textView just to detect typing
    var textShown1 = CustomTextView()
    var paragraphStrings: [NSMutableAttributedString] = [] // An array that all the other AttributedStrings are attached to
    var paragraphs: [CustomTextView] = [] // An array that all the other textViews are added to
    var currentString = Int() // Integer that points to item in AS array
    var currentParagraph = Int() // The integer that points to which item in the paragraph array
    var textForPlayer = NSMutableAttributedString()
    var textViewForPlayer = CustomTextView()
    var totalCharsShown = Int()
    var rangeOfText = Int() // For the addToRange function which moves the selected character of the visible UITextView
    public var paragraphCount = 6
    var delayShrink = Double()
    
    // Timer Bar
    var bgTimerBar = SKSpriteNode()
    let timerCrop = SKCropNode()
    let timerBarEdge = SKSpriteNode()
    var fgTimerBar = SKSpriteNode()
    var timerBar = SKSpriteNode()
    var medals = 3
    
    public var currentLevel: Int = 1

    // Transition Scene Button Variable Declaration
//    let titleScreenNode = SKSpriteNode(color: SKColor .greenColor(), size: CGSizeMake(150.0, 100.0))
    
    // Characters Typed or Required to be typed
    var charTyped = String()
    var charRequired = String()

    // Score Counter
    var correctCharsTyped = SKLabelNode()
    var mistakesMade = Int()
    let mistakeMarkerTexture = SKTexture(imageNamed: "inGameMistake.png")
    var mistakeMarkers = [SKSpriteNode]()
    
    // Game Layers
    let gameLayer = SKNode()
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
    
    // Header Bar
    var header = SKSpriteNode()
    var bgContainer = SKSpriteNode()
    
    // Progress Bar
    var progressMarkerOff = SKSpriteNode()
    var progressMarkerOn = SKSpriteNode()
    var progressMarkers = [SKSpriteNode]()
    
    // Labels
    var levelTitle = SKLabelNode()
    var levelHighScore = SKLabelNode()
    
    // Pug Face
    var pug = SKSpriteNode()
    let pug1 = SKTexture(imageNamed: "inGamePug-1.png")
    let pug2 = SKTexture(imageNamed: "inGamePug-2.png")
    let pug3 = SKTexture(imageNamed: "inGamePug-3.png")
    
    let ringTexture = SKTexture(imageNamed: "inGameAnimRing.png")
    
    let timeManager = TimeManager.sharedInstance
    
    // -------------------------- INITs
    
    override init(size: CGSize) {
    super.init(size: size)
        
        // Add Game Layer
        self.addChild(gameLayer)
        
        // Add Labels
        levelTitle.fontName = "LeagueGothic-Regular"
        levelTitle.text = "THE FIRST LEVEL"
        levelTitle.position = CGPoint(x: CGRectGetMidX(self.frame)-158, y: CGRectGetMidY(self.frame)+210)
        levelTitle.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        levelTitle.fontSize = 48.0
        gameLayer.addChild(levelTitle)
        
        levelHighScore.fontName = "Sertig"
        levelHighScore.text = "HIGH SCORE: 40.2s"
        levelHighScore.position = CGPoint(x: 5, y: -17)
        levelHighScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        levelHighScore.fontSize = 15.0
        levelTitle.addChild(levelHighScore)
        
        // Add BG Lighter Color Container
        bgContainer.size = CGSize(width: 150, height: CGRectGetMaxY(self.frame))
        bgContainer.color = UIColor(netHex: 0x724058)
        bgContainer.position = CGPoint(x: CGRectGetMaxX(self.frame) - 70, y: CGRectGetMaxY(frame))
        bgContainer.anchorPoint = CGPoint(x: 0, y: 1)
        gameLayer.addChild(bgContainer)
    
        // SKView Properties
        self.backgroundColor = UIColor(netHex: 0x66384d)
        
        // Timer Bar Initialize
        bgTimerBar = SKSpriteNode(imageNamed: "inGameTimerGoldBot.png")
        bgTimerBar.position = CGPoint(x: 0, y: (CGRectGetMaxY(self.frame)))
        bgTimerBar.anchorPoint = CGPoint(x: 0,y: 1)
        bgTimerBar.size.width = (self.size.width)
        bgTimerBar.size.height = 40
        bgTimerBar.zPosition = 0
        gameLayer.addChild(bgTimerBar)
        
        fgTimerBar = SKSpriteNode(imageNamed: "inGameTimerGoldTop.png")
        fgTimerBar.position = CGPoint(x: 0, y: (CGRectGetMaxY(self.frame)))
        fgTimerBar.anchorPoint = CGPoint(x: 0,y: 1)
        fgTimerBar.size.width = (self.size.width)
        fgTimerBar.size.height = 40
        
        // Used to determine width of other timer bars
        timerBar.color = SKColor(red: 255/255, green: 251/255, blue: 207/255, alpha: 1.0)
        timerBar.position = CGPoint(x: 0, y: (CGRectGetMaxY(self.frame)))
        timerBar.anchorPoint = CGPoint(x: 0,y: 1)
        timerBar.size.width = (self.size.width)
        timerBar.size.height = 40
        
        timerCrop.zPosition = 1

        // Create the edge of the bar. Child of timerBar to follow it's max X value
        // Also need to add the timerBar or edge won't show
        timerBarEdge = SKSpriteNode(imageNamed: "inGameTimerEdge.png")
        timerBarEdge.anchorPoint = CGPoint(x: 1,y: 1)
        timerBarEdge.size.height = 42
        timerBarEdge.size.width = 25
        timerBarEdge.zPosition = 3
        // timerBar.addChild(timerBarEdge)
        gameLayer.addChild(timerBar)
        gameLayer.addChild(timerBarEdge)
        
        // 1. crop node's child is the node that is visible, but being masked by something else
        // 2. crop node's maskNode property is the thing that will mask the child.
        // 3. add the crop node to the scene.
        timerCrop.maskNode = timerBar
        timerCrop.addChild(fgTimerBar)
        gameLayer.addChild(timerCrop)
        
        // Transition Scene button
//        self.titleScreenNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame))
//        self.addChild(titleScreenNode)
        
        // Type
        let textFont = [NSFontAttributeName: UIFont(name: "GillSansMT", size: 26.0) ?? UIFont.systemFontOfSize(18.0)]
        let italFont = [NSFontAttributeName: UIFont(name: "Georgia-Italic", size: 40.0) ?? UIFont.systemFontOfSize(18.0)]
        // Define string attributes
        
        // Create locally formatted strings
        attrString1 = NSMutableAttributedString(string: "My name is Dug. I am a pug.", attributes: textFont)
        attrString2 = NSMutableAttributedString(string: "I have a male man who lives with me. His name is John.", attributes: textFont)
        attrString3 = NSMutableAttributedString(string: "John has recently started meeting a female man", attributes: textFont)
        attrString4 = NSMutableAttributedString(string: "I know it is a female man, because of her fur.", attributes: textFont)
        attrString5 = NSMutableAttributedString(string: "It is long like an English Sheepdog", attributes: textFont)
        attrString6 = NSMutableAttributedString(string: "except that an English Sheepdog is beautiful.", attributes: textFont)
        attrString7 = NSMutableAttributedString(string: "", attributes: textFont)
        attrString8 = NSMutableAttributedString(string: "", attributes: textFont)
        
        paragraphStrings = [attrString1, attrString2, attrString3, attrString4, attrString5, attrString6, attrString7, attrString8]
        
        // Texture for the Header
        let headerTexture = SKTexture(imageNamed: "inGameHeader-1.png")
        header = SKSpriteNode(texture: headerTexture)
        header.position = CGPoint(x: 0, y: CGRectGetMaxY(self.frame)-39)
        header.size.width = CGRectGetWidth(self.frame)
        header.size.height = 150
        header.anchorPoint = CGPoint(x: 0,y: 1)
        gameLayer.addChild(header)
        
        for i in 1...3 {
            
            let marker = SKSpriteNode(texture: mistakeMarkerTexture)
            marker.xScale = 0.4
            marker.yScale = 0.4
            
            let gap = CGFloat(i) * marker.size.width
            marker.position = CGPoint(x: gap - 10, y: -148)
            marker.zPosition = -1
            mistakeMarkers.append(marker)
            header.addChild(marker)
            
        }
        
        // Progress for paragraphs marker ** PROBABLY A BETTER WAY TO DO THIS WITH TEXTURES LIKE PUGFACE
        progressMarkerOn = SKSpriteNode(imageNamed: "inGameProgress-ON.png")
        let progressTileWidth = progressMarkerOn.size.width / 4
        let progressTileGap = progressTileWidth * 1.2
        let selectorWidth = progressTileWidth * CGFloat(paragraphCount) + (progressTileGap * CGFloat(paragraphCount)-2)
        var x: CGFloat = 33
        var y = self.frame.height / 2 + 80
        
        for i in 1...paragraphCount {
            
            self.progressMarkerOff = SKSpriteNode(imageNamed: "inGameProgress-OFF.png")
            let progressMarker = self.progressMarkerOff
            progressMarker.name = "marker\(i)"
            progressMarkerOff.position = CGPoint(x: x, y: y)
            progressMarkerOff.xScale = 0.3
            progressMarkerOff.yScale = 0.3
            
            x += progressTileWidth + progressTileGap
            progressMarkers.append(progressMarker)
            gameLayer.addChild(progressMarker)
        }

        // Init PugFace
        pug = SKSpriteNode(texture: pug3)
        pug.xScale = 0.4
        pug.yScale = 0.4
        pug.position = CGPoint(x: CGRectGetMidX(self.frame)+120, y: CGRectGetMidY(self.frame)+225)
        gameLayer.addChild(pug)
        
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // --------------------------- GAME METHODS
    
    override public func didMoveToView(view: SKView) {
        
        // Add UITextViews
        addUIElements()
        
        startGame()
        
    }
    
    func addUIElements() {
        
        // Add Underline to first attrString in array
        paragraphStrings[0].addAttribute(
            NSUnderlineStyleAttributeName,
            value: NSUnderlineStyle.StyleDouble.rawValue,
            range: NSMakeRange(0, 1))
        
        // Create UITextView
        textDisplay = UITextView(frame: CGRect(x: 0, y: 20, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-60))
        
        for i in 0..<paragraphCount {
            
            var paragraphNumber: CGFloat = CGFloat(i) + 1
            // Missing 'argument textContainer in call below', various other errors like 'consuective statements on a line must be separated by ;'
            textShown1 = CustomTextView(frame: CGRectMake(22, 175 + (90 * paragraphNumber), CGRectGetWidth(self.frame) - 80, CGRectGetHeight(self.frame)-400))
            textShown1.backgroundColor = UIColor.clearColor()
            // Re-positions textView to center of X. replaces Rect above
//            textShown1.center.x = CGRectGetMidX(self.frame)
            paragraphs.append(textShown1)
            
            // Make the paragraphs the default colour
            paragraphStrings[i].addAttribute(
                NSForegroundColorAttributeName,
                value: UIColor(netHex: 0xcd948b),
                range: NSRange(location: 0, length: paragraphStrings[i].length))
            
            // Add the attributes to the attributed text
            textShown1.attributedText = paragraphStrings[i]
            
            self.view?.addSubview(textShown1)
            
        }
        
        // Bring Up Keyboard Immediately
        textDisplay.autocorrectionType = UITextAutocorrectionType.No
        textDisplay.becomeFirstResponder()
        textDisplay.keyboardType = UIKeyboardType.Default
        
        // Add string to UITextView
        textDisplay.attributedText = attrString1
        
        // Visibility of the hidden textView
        textDisplay.hidden = true
        
        // Add UITextView to main view
        self.view?.addSubview(textDisplay)
        
        // Creating Arrays of TextViews and AttributedStrings to be used in cursor mvmt
        textViewForPlayer = paragraphs[0]
        textForPlayer = paragraphStrings[0]
        
        // Assign the UITextView's(textDisplay's) delegate to be the class we're in.
        textDisplay.delegate = self

    }
    
    func startGame() {
        
        timeManager.startTimer(levelAllottedTimeMin: 49, levelAllottedTimeMax: 51)
        
        timerBar.size.width = (self.size.width)
        timerBar.runAction(SKAction.scaleXTo(0, duration: Double(timeManager.gameTime)))
        // Moves the edge of the timerBar (a child of timerBar) to stick to the same max X value of the frame of parent
        // self.timerBarEdge.runAction(SKAction.moveToX((CGRectGetMaxX(timerBar.frame)), duration: 0))
        
        // Sets the first character required to 0
        rangeOfText =  0
        
        // Sets mistakes to 0
        mistakesMade = 0
        
        // variables to set the array index of paragraphs & paragraphStrings back to 0
        currentParagraph = 0
        currentString = 0
        
        // Shrink delay between paragraphs
        delayShrink = 1.5
        
        // Reset Paragraph to default color
        attrString1.addAttribute(NSForegroundColorAttributeName, value: UIColor(netHex: 0xcd948b), range: NSRange(location: 0, length: attrString1.length))
        attrString1.addAttribute(NSBackgroundColorAttributeName, value: UIColor.clearColor(), range: NSRange(location: 0, length: attrString1.length))
        
        scene?.userInteractionEnabled = true
    }
    
    // Handles Game Over Functions
    func gameEnded(#didWin: Bool) {
        
        timeManager.timer.invalidate()
        
        if didWin {
            
            println("WIN")
            let scene = LevelFinishedScene(gameScene: self, size: self.size)
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
    
    public func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        // WHAT IS HAPPENING HERE:
        // Tracking an incrementing string character in the chosen TextView
        // Changing the attributes of an attributed string in the chosen TextView
        
        var charTyped = text // Character that was typed
        totalCharsShown = (countElements(textViewForPlayer.text)) // Used to detect win condition
        var charRequired = String() // Character that needs to be typed next
        var paraAnimDelay = Double() // Used for the animation of paragraphs
        
        // Since changing the attributed String range REQUIRES an NSRange 
        // (rangeOfTextShown is a Range, not NSRange - the testRange String 
        // is converted to NSString, so that we can make a NSRange of out it)
        let nsRangeOfTextShown = NSMakeRange(rangeOfText, 1)
        // let nsText = textShown.text as NSString
        // let attributedString = NSMutableAttributedString(string: nsText)
        // Above not needed because i DID using para as the attributed string

        // Finding the current selection of character that needs to be typed from the visible UITextView
        var rangeOfTextShown: Range = Range(
            start: advance(textViewForPlayer.text.startIndex, rangeOfText),
            end: advance(textViewForPlayer.text.startIndex, rangeOfText + 1))
        charRequired = textViewForPlayer.text.substringWithRange(rangeOfTextShown)
        
        // logic for underline changing along with incrementing text range to determine character required
        if totalCharsShown > (rangeOfText + 1) {
            
            // Creates the Underline. Removes first underline which was just manually put in place when gameScene init
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
                
//                // BELOW NOT NEEDED NOW BECAUSE OF ANIMATION.
//                // Changes the color of the text if correct letter was typed
//                textForPlayer.addAttribute(
//                    NSForegroundColorAttributeName,
//                    value: UIColor(netHex: 0x8b505c),
//                    range: nsRangeOfTextShown)
//                // have to make sure to add the attributed text string to the UITextView or it won't show
//                
//                textViewForPlayer.attributedText = textForPlayer
                
                animateTypeCorrect(nsRange: nsRangeOfTextShown, character: charRequired)
                
            } else if charTyped != charRequired {
                
                println("FALSE")
                
                animateTypeIncorrect(nsRange: nsRangeOfTextShown)
                
            }

            if rangeOfText < (totalCharsShown - 1) {
                
                // Moves the marker forward to the next required character in visible UITextView
                addToRange()
            }
            
        } else { // This is when player reaches end of a paragraph
            
            // Updates the ProgressNodes
            updateProgressNodes()
            
            // Logic for matching character typed to character required - AGAIN. 
            // THERE IS PROBABLY A BETTER WAY TO DO THIS THAN REPEATING CODE
            if charTyped == charRequired {
                
                println("CORRECT")
                
                updatePug(state: .happy)
                
                animateTypeCorrect(nsRange: nsRangeOfTextShown, character: charRequired)
                
            } else if charTyped != charRequired {
                
                println("FALSE")
                
                animateTypeIncorrect(nsRange: nsRangeOfTextShown)
                
            }
            
            // Removes the last underline
            textForPlayer.removeAttribute(
                NSUnderlineStyleAttributeName,
                range: NSMakeRange((rangeOfText), 1))
            textViewForPlayer.attributedText = textForPlayer
            
            // This if statement will increment the current TextView selected for identifying characters required/shown,
            // along with the current attributed string that needs to now have its new attributes changed.
            // paragraphs.count is -1 because it counts 3 items, when an array starts index 0 ie (0,1,2) != (1,2,3)
            if currentParagraph < paragraphs.count - 1 {
                
                // Animates the paragraphs going down, and back up
                UIView.animateWithDuration(0.3, delay: 0.25, options: .CurveEaseOut, animations: {
                    self.textViewForPlayer.alpha = 0.0
                    }, completion: { finished in
                        }
                    )
                
                paraAnimDelay = 0 // To reset this value to be used in the for loop for animatinag paras below
                
                for i in (currentParagraph + 1)..<(paragraphCount) {
                    
                    paraAnimDelay++
                    var delay: Double = (1 / 6) * Double(paraAnimDelay)
                    UIView.animateWithDuration(0.1, delay: (0.15 + delay), options: .CurveEaseOut, animations: {
                        var frame = self.paragraphs[i].frame
                        frame.origin.y += 10
                        self.paragraphs[i].frame = frame
                        }, completion: { finished in
                            UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
                                var frame = self.paragraphs[i].frame
                                frame.origin.y -= 100
                                self.paragraphs[i].frame = frame
                                }, completion: { finished in
                                    }
                            )}
                    )
                }
                
                textDisplay.userInteractionEnabled = false
                
                delayShrink -= 0.1
                // Delays this until after the animation block executes
                delay(delayShrink) {
                    // I have to put the incrementation in here, otherwise .animateWithDuration will return immediately,
                    // while the completion block happens after the incrementation.
                    // self.textViewForPlayer.removeFromSuperview()
                    self.textViewForPlayer = self.paragraphs[++self.currentParagraph]
                    self.textForPlayer = self.paragraphStrings[++self.currentString]
                    
                    println("\(self.currentParagraph) in \(self.paragraphs.count)")
                    self.rangeOfText = 0
                    
                    // adds the initial underline back into the next paragraph
                    self.textForPlayer.addAttribute(
                        NSUnderlineStyleAttributeName,
                        value: NSUnderlineStyle.StyleDouble.rawValue,
                        range: NSMakeRange(0, 1))
                    self.textViewForPlayer.attributedText = self.textForPlayer
                    
                    self.textDisplay.editable = true
                    self.textDisplay.userInteractionEnabled = true
                    println("TRUE")
                    
                    self.updatePug(state: .proud)
                }
                
            } else if currentParagraph == paragraphs.count - 1 {
                
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
        
        if mistakesMade == 3 {
            
            self.textDisplay.editable = false
            
            delay(1.0) {
                self.gameEnded(didWin: false)
            }
        }
        
        return true
    }
    
// CA Animation experiment
//    func animateCharacters() {
//        var fadeOut = CABasicAnimation(keyPath: "opacity")
//        fadeOut.duration = 0.5
//        fadeOut.fillMode = kCAFillModeForwards
//        fadeOut.toValue = NSNumber(double: 0.0)
//        
//    }
    func animateTypeCorrect(#nsRange: NSRange, character: String) {
        
        // Animates the type flashing white, and then fading to a subtle bg color
        UIView.transitionWithView(textViewForPlayer, duration: 0.1, options: .BeginFromCurrentState | .TransitionCrossDissolve | .AllowAnimatedContent, animations: {
            self.textForPlayer.addAttribute(
                NSForegroundColorAttributeName,
                value: UIColor.whiteColor(),
                range: nsRange)
            self.textViewForPlayer.attributedText = self.textForPlayer
            }, completion: { finished in
                UIView.transitionWithView(self.textViewForPlayer, duration: 0.2, options: .BeginFromCurrentState | .TransitionCrossDissolve | .AllowAnimatedContent, animations: {
                    self.textForPlayer.addAttribute(
                        NSForegroundColorAttributeName,
                        value: UIColor(netHex: 0x8b505c),
                        range: nsRange)
                    self.textViewForPlayer.attributedText = self.textForPlayer
                    }, completion: { finished in
                })
            }
        )
        
        // Not animating particles for spaces.
        if character != " " {
            
            // Particle for typing
            let sparkParticle = SKEmitterNode(fileNamed: "MyParticle")
            
            textViewForPlayer.layoutManager.ensureLayoutForTextContainer(
                textViewForPlayer.textContainer)
            
            // Find the rect of the individual character in range of being typed
            let start = textViewForPlayer.positionFromPosition(textViewForPlayer.beginningOfDocument, offset: nsRange.location)!
            let end = textViewForPlayer.positionFromPosition(start, offset: nsRange.length)!
            let tRange = textViewForPlayer.textRangeFromPosition(start, toPosition: end)
            let rect = textViewForPlayer.firstRectForRange(tRange)
            let x = rect.midX + textViewForPlayer.frame.minX
            // negative rect because of the origin. -5 is cus x-height of lower case letters is a little lower. to centre it.
            let y = -rect.midY + textViewForPlayer.textContainerInset.top + textViewForPlayer.frame.midY - 5
            
            println("\(nsRange)")
            println("x: \(x), y: \(y)")
            sparkParticle.position = CGPoint(x: x, y: y)
            
            gameLayer.addChild(sparkParticle)
            
            var ring = SKSpriteNode()
            
            ring.texture = ringTexture
            ring.position = CGPoint(x: x, y: y)
            ring.alpha = 0.3
            ring.size = CGSize(width: 50, height: 50)
            ring.runAction(SKAction.fadeOutWithDuration(0.2))
            ring.runAction(SKAction.scaleTo(2.0, duration: 0.15))
            gameLayer.addChild(ring)
            
            delay(1.0) {
                sparkParticle.removeFromParent()
                ring.removeFromParent()
            }
        }
    }
    
    func animateTypeIncorrect(#nsRange: NSRange) {
        
        // rotates mistakes counter
        rotateMistakes(mistakeCounter: mistakesMade)
        ++mistakesMade
        
        // Changes the color of the text if incorrect letter was typed
        textForPlayer.addAttribute(
            NSForegroundColorAttributeName,
            value: UIColor(red: 209/255, green: 23/255, blue: 23/255, alpha: 1.0),
            range: nsRange)
        textForPlayer.addAttribute(
            NSBackgroundColorAttributeName,
            value: UIColor(red: 201/255, green: 121/255, blue: 129/255, alpha: 0.5),
            range: nsRange)
        textViewForPlayer.attributedText = textForPlayer
        
        updatePug(state: .sad)
    }
    
    func updateProgressNodes() {
        
        var progressNode = progressMarkers[currentParagraph]
        
        progressNode = SKSpriteNode(imageNamed: "inGameProgress-ON.png")
        // Makes the new node same position as old one
        progressNode.position = progressMarkers[currentParagraph].position
        progressNode.xScale = 0.3
        progressNode.yScale = 0.3
        
        let scaleUp = SKAction.scaleTo(0.5, duration: 0.1)
        let scaleDown = SKAction.scaleTo(0.3, duration: 0.2)
        progressNode.runAction(SKAction.sequence([scaleUp, scaleDown]))
        
        gameLayer.addChild(progressNode)
        
    }
    
    func updatePug(#state: PugFace) {
        
        switch state {
        case .happy:
            pug.texture = pug1
        case .sad:
            pug.texture = pug2
        case .proud:
            pug.texture = pug3
        default:
            println("NON EXISTENT PUG")
        }
        
        let scaleUp = SKAction.scaleTo(0.5, duration: 0.1)
        let scaleDown = SKAction.scaleTo(0.4, duration: 0.2)
        pug.runAction(SKAction.sequence([scaleUp, scaleDown]))
    }
    
    func rotateMistakes(#mistakeCounter: Int) {
        
        let mistakeCounterSprite = mistakeMarkers[mistakeCounter]
        let oneEightyDegrees = CGFloat(π)
        
        let rotateRight = SKAction.rotateByAngle(3.8, duration: 0.6)
        let rotateLeft = SKAction.rotateToAngle((oneEightyDegrees-0.2), duration: 0.2)
        let rotateRight2 = SKAction.rotateToAngle(oneEightyDegrees, duration: 0.1)
        rotateRight.timingMode = SKActionTimingMode.EaseOut
        rotateLeft.timingMode = SKActionTimingMode.EaseIn
        mistakeCounterSprite.runAction(SKAction.sequence([rotateRight, rotateLeft, rotateRight2]))
    }
    
    func changeTimerColor(medals pointsAwarded: Int) {
        
        switch pointsAwarded {
            
        case 1:
            self.bgTimerBar = SKSpriteNode(imageNamed: "inGameTimerBronBot.png")
            self.fgTimerBar = SKSpriteNode(imageNamed: "inGameTimerBronTop.png")
        case 2:
            self.bgTimerBar = SKSpriteNode(imageNamed: "inGameTimerSilvBot.png")
            self.fgTimerBar = SKSpriteNode(imageNamed: "inGameTimerSilvTop.png")
        case 3:
            self.bgTimerBar = SKSpriteNode(imageNamed: "inGameTimerGoldBot.png")
            self.fgTimerBar = SKSpriteNode(imageNamed: "inGameTimerGoldTop.png")
        default: println("No timer bar")
            
        }
        
        self.bgTimerBar.position = CGPoint(x: 0, y: (CGRectGetMaxY(self.frame)))
        self.bgTimerBar.anchorPoint = CGPoint(x: 0,y: 1)
        self.bgTimerBar.size.width = (self.size.width)
        self.bgTimerBar.size.height = 40
        self.bgTimerBar.zPosition = 0
        
        gameLayer.addChild(bgTimerBar)
        
        self.fgTimerBar.position = CGPoint(x: 0, y: (CGRectGetMaxY(self.frame)))
        self.fgTimerBar.anchorPoint = CGPoint(x: 0,y: 1)
        self.fgTimerBar.size.width = (self.size.width)
        self.fgTimerBar.size.height = 40
        
        timerCrop.addChild(fgTimerBar)
        
    }
    
    override public func willMoveFromView(view: SKView) {
        
        // Remove these UITextViews from the SKView
        textDisplay.removeFromSuperview()
        
        for i in 0..<paragraphCount {
            paragraphs[i].removeFromSuperview()
        }

    }
    
    override public func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.timerBarEdge.position = CGPoint(x: CGRectGetMaxX(timerBar.frame), y: (CGRectGetMaxY(self.frame)))
        
        // For Bronze/silver colors of TimerBar
        var sceneHalfSize = self.frame.width / 2
        
        if medals == 2 && timerBar.size.width < sceneHalfSize / 2 {
            
            medals = 1
            println("CHANGE")
            changeTimerColor(medals: 1)
            
        }
        else if medals == 3 && timerBar.size.width < sceneHalfSize {
            
            medals = 2
            changeTimerColor(medals: 2)
            
        }
        
        if timerBar.size.width == 0 {
            
            gameEnded(didWin: false)
        }
    }
}
