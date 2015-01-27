//
//  Extensions.swift
//  qwerty2
//
//  Created by Chris Lee on 2015-01-08.
//  Copyright (c) 2015 Coffee Digital. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension SKNode {
    
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as TitleScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
    
    class func cleanupScene(node: SKNode) {
        for child in node.children as [SKNode] {
            cleanupScene(child)
        }
        node.removeFromParent()
    }
}

extension SKScene {
    
    // Our scene scale factor (to map it to the view)
    //
    // Any sprites we add to the scene need which aren't specifically sized to some dimension of the scene's
    // frame property will need to have their xScale/yScale multiplied by the sceneScale's width/height:
    func getSceneScale() -> CGSize {
        return CGSize(width: getSceneScaleX(), height: getSceneScaleY())
    }
    
    func getSceneScaleX() -> CGFloat {
        return frame.width / view!.frame.width
    }
    
    func getSceneScaleY() -> CGFloat {
        return frame.height / view!.frame.height
    }
}
