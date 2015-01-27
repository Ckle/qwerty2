//
//  Files.swift
//  qwerty2
//
//  Created by Chris Lee on 2015-01-27.
//  Copyright (c) 2015 Coffee Digital. All rights reserved.
//

import Foundation

class File {
    
    class func exists (path: String) -> Bool {
        return NSFileManager().fileExistsAtPath(path)
    }
    
    class func read (path: String, encoding: NSStringEncoding = NSUTF8StringEncoding) -> String? {
        if File.exists(path) {
            return String(contentsOfFile: path, encoding: encoding, error: nil)!
        }
        
        return nil
    }
    
    class func write (path: String, content: String, encoding: NSStringEncoding = NSUTF8StringEncoding) -> Bool {
        return content.writeToFile(path, atomically: true, encoding: encoding, error: nil)
    }
}

let read : String? = File.read("/path/to/file.txt")