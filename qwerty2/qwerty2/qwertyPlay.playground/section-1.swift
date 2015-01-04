// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func addUIElements() {
    
    // Type
    let textFont = [NSFontAttributeName: UIFont(name: "Georgia", size: 18.0) ?? UIFont.systemFontOfSize(18.0)]
    let italFont = [NSFontAttributeName: UIFont(name: "Georgia-Italic", size: 18.0) ?? UIFont.systemFontOfSize(18.0)]
    
    // Define string attributes
    // Create a string that will be our paragraph
    let para = NSMutableAttributedString()
    
    // Create locally formatted strings
    let attrString1 = NSAttributedString(string: "Hello Swift! This is a tutorial looking at ", attributes:textFont)
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
    
    // Create UITextView
    textDisplay = UITextView(frame: CGRect(x: 0, y: 20, width: CGRectGetWidth(self.frame), height: CGRectGetHeight(self.frame)-60))
    
    // Bring Up Keyboard Immediately
    textDisplay.autocorrectionType = UITextAutocorrectionType.No
    textDisplay.becomeFirstResponder()
    // textDisplay.hidden = true
    textDisplay.keyboardType = UIKeyboardType.EmailAddress
    
    // Add string to UITextView
    textDisplay.attributedText = para
    textDisplay.hidden = true
    // Add UITextView to main view
    self.view?.addSubview(textDisplay)
    
    // Assign the UITextView's(textDisplay's) delegate to be the class we're in.
    textDisplay.delegate = self
    
}
    