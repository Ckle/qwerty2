//
//  OtherMacros.swift
//  qwerty2
//
//  Created by Chris Lee on 2015-02-11.
//  Copyright (c) 2015 Coffee Digital. All rights reserved.
//

import Foundation
import SpriteKit

// Enum for pug's face
enum PugFace {
    case sad, proud, happy
}
// To make sure the textview cannot be tapped on.
class CustomTextView: UITextView {
    
    override func canBecomeFirstResponder() -> Bool {
        
        return false
    }
}

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}


