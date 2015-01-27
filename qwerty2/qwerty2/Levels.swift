//
//  Levels.swift
//  qwerty2
//
//  Created by Chris Lee on 2015-01-02.
//  Copyright (c) 2015 Coffee Digital. All rights reserved.
//

import Foundation
import UIKit

class Levels {
    
    // **USING THE FUNCTION THAT IS CALLED IN LEVEL SELECT SCENE, HAVE AN ARRAY OF CONTENT THAT WILL BE CALLED INSIDE GAMESCENE WHEN DRAWING THE SCENE. INSIDE GAMESCENE WILL CALL THE CONTENT ACCORDING TO THE CURRENT LEVEL ASSIGNED TO THE PUBLIC VARIABLE IN THAT CLASS.
    
    //1
    func createLevel() {
    var lvl1 = UITextView()
    let textFont = [NSFontAttributeName: UIFont(name: "Georgia", size: 18.0) ?? UIFont.systemFontOfSize(18.0)]
    
    // Define string attributes
    // Create a string that will be our paragraph
    let para = NSMutableAttributedString()
    
    // Create locally formatted strings
    let attrString1 = NSAttributedString(string: "THIS IS LEVEL 1", attributes:textFont)
    
    // Add locally formatted strings to paragraph
    para.appendAttributedString(attrString1)
    para.addAttribute(NSFontAttributeName, value: UIFont(name: "Georgia", size: 18.0)!, range: NSRange(location: 7, length: 5))
    
    // Define paragraph styling
    let paraStyle = NSMutableParagraphStyle()
    paraStyle.firstLineHeadIndent = 15.0
    paraStyle.paragraphSpacingBefore = 10.0
    
    // Apply paragraph styles to paragraph
    para.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSRange(location: 0,length: para.length))
    
    //lvl1 = UITextView(frame: CGRect(x: 0, y: 20, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-60))
        
    lvl1.hidden = false
        
        // Add string to UITextView
    lvl1.attributedText = para
        // Add UITextView to main view
    //self.view?.addSubview(lvl1)
    }
}
