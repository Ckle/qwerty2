//
//  TimeManager.swift
//  qwerty2
//
//  Created by Mark Hazlett on 2015-02-16.
//  Copyright (c) 2015 Coffee Digital. All rights reserved.
//

import Foundation

private let _TimeManagerSharedInstance = TimeManager()

class TimeManager {
    var time = ""
    
    class var sharedInstance: TimeManager {
        return _TimeManagerSharedInstance
    }
    
    public func startTimer() {
        self.time = "Start"
    }
    
    public func stopTimer() {
        self.time = "Finished"
    }
    
    public func getFinalTime() -> NSString {
        return self.time
    }
}

