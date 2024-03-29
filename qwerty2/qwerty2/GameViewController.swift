//
//  GameViewController.swift
//  qwerty2
//
//  Created by Chris Lee on 2014-12-17.
//  Copyright (c) 2014 Coffee Digital. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class GameViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = TitleScene.unarchiveFromFile("TitleScene") as? TitleScene {
            // Configure the view.
            let skView = self.view as SKView
            skView.showsFPS = true
            scene.size = skView.bounds.size
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .ResizeFill
            
            skView.presentScene(scene)
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.Portrait.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
