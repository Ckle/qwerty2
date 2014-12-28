// Playground - noun: a place where people can play

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    @IBAction func myFontButton(sender: UIButton) {
    }

var myString = "I Love Pizza!"
var myMutableString = NSMutableAttributedString()


myMutableString = NSMutableAttributedString(string: myString, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 18)!])

myLabel.attributedText = myMutableString

