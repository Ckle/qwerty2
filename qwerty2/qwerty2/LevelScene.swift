//
//  GameScene2.swift
//  qwerty2
//
//  Created by Chris Lee on 2014-12-18.
//  Copyright (c) 2014 Coffee Digital. All rights reserved.
//

import SpriteKit

class LevelScene: SKScene {
    
    
    // Constants
    let levelButton = SKSpriteNode(color: SKColor .greenColor(), size: CGSizeMake(25.0, 25.0))
    let maxLevels = 4
    
    // Vars
    var isLoading: Bool = false
    // var progressLoader: ProgressLoaderNode!
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor(red: 81/255, green: 150/255, blue: 111/255, alpha: 1.0)
        
        addLevelSelectandHighScore()
    }
    
    internal func addLevelSelectandHighScore() {
        
        var suffix = "enabled"
        
        let atlas = SKTextureAtlas(named: "Levels")
        let levelTile = atlas.textureNamed("L1-enabled")
        
        // In order to create a grid for the level buttons,
        // we a tile width, height and a value for the gap
        // in between them.
        var tileWidth = levelTile.size().width
        var tileHeight = levelTile.size().height
        var gap = tileWidth / 2
        
        // We also need a selector width and an initial x
        // and y coordinate set.
        var selectorWidth = tileWidth * CGFloat(maxLevels) + gap * CGFloat(maxLevels - 2)
        
        // subtract the selector width from the width of the 
        // entire view and divide that value by two in order to get the center
        var x = (self.frame.width - selectorWidth) / 2
        var y = self.frame.height / 2
        
        for i in 1...maxLevels {
            
            let level = SKSpriteNode(texture: atlas.textureNamed("L\(i)-\(suffix)"))
            level.name = "\(i)"
            level.position = CGPoint(x: x, y: y)
            level.xScale = getSceneScaleX()
            level.yScale = getSceneScaleY()
            
            x += tileWidth + gap
            addChild(level)
        }
        
    }
    
    internal func loadLevel(level: String) {
       
        // If we're already loading a level, disallow
        // other levels being loaded.
        if isLoading {
            NSLog("Avoiding interruptive load")
            return
        }
        
        isLoading = true
        
        // Declare the scene variable as nil so you can 
        // reference it from any closure functions used later to do the background operations.
        // var scene: GameScene? = nil
        // Create an array where you can store empty closure functions. 
        // The point of this is to eventually run this array of functions 
        // in the background loading. I removed the other work however, refer to SafariBooks if i want to implement background loading. I'd have to Load the current level as variable "scene" and append it to the array.
        var work: [Void -> Any?] = []
        
        var scene = GameScene(size: self.size)
        self.view?.presentScene(scene)
        
        // ** CREATE A FUNCTION THAT LOADS CONTENT FROM THE LEVEL CLASS
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
      //  func loadLevel
        
        for touch: AnyObject in touches {
            
            // Below is a more proper way? to make sure the touch is the node at a particular point.
            // let location = touch.locationInNode(self)

            let node = self.nodeAtPoint(touch.locationInNode(self))
            
            if node.name == "1" || node.parent?.name == "1" {
                loadLevel("1")
            }
//            if node.name == "2" || node.parent?.name == "2" {
//                loadLevel("2")
//            }
//            if node.name == "3" || node.parent?.name == "3" {
//                loadLevel("3")
//            }
//            if node.name == "4" || node.parent?.name == "4" {
//                loadLevel("4")
//            }
            
            
        }
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
