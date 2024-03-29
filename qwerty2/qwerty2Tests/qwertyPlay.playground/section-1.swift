// Playground - noun: a place where people can play

import UIKit
import Foundation

class File {
    
    class func exists (path: String) -> Bool {
        return NSFileManager().fileExistsAtPath(path)
    }
    
    class func read (path: String, encoding: NSStringEncoding = NSUTF8StringEncoding) -> String? {
        if File.exists(path) {
            return String(contentsOfFile: path, encoding: encoding, error: nil)
        }
        
        return nil
    }
    
}

let read : String? = File.read("/Users/chris_lee/Documents/Coffee/qwerty2/qwerty2/qwerty2/1.txt")

println("\(read)")

    
var paragraphs: [String] = ["Hi", "Hello"]

paragraphs[0]
