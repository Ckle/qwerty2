//
//  TimeManager.swift
//  qwerty2
//
//  Created by Chris Lee on 2015-02-17.
//  Copyright (c) 2015 Coffee Digital. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

private let _TimeManagerSharedInstance = TimeManager()

public class TimeManager {
    
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var gameTime = CGFloat()
    var currentTime = NSTimeInterval()
    var elapsedTime = Double()
    var seconds = Double()
    
    // Creates Singleton, which allows the private declaration above to reference the same instance
    // of TimeManager. that way the variables can be passed around between V/C classes
    class var sharedInstance: TimeManager {
        return _TimeManagerSharedInstance
    }

    public func startTimer(#levelAllottedTimeMin: Int, levelAllottedTimeMax: Int) {
        // Starts Timer
        var allotedTime: UInt32 = levelAllottedTimeMax - levelAllottedTimeMin + 1
        gameTime = CGFloat((arc4random() % (allotedTime)) + levelAllottedTimeMin)
        let aSelector: Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        
    }
    
    // Updates Timer Bar
    @objc public func updateTime() {
        
        currentTime = NSDate.timeIntervalSinceReferenceDate()
        elapsedTime = Double(currentTime) - Double(startTime)
        seconds = Double(Double(gameTime) - elapsedTime)
        
        if seconds > 0 {
            
            elapsedTime -= NSTimeInterval(seconds)
            println("\(Double(seconds))")
            
        } else {
            
            timer.invalidate()

        }
        
        // **Keep for learning purposes**
        // var secondsLeft = CGFloat(seconds / gameTime)
        // self.timerBar.size.width = ((self.size.width) * secondsLeft)
        // self.timerBar.size.width = SKAction.scaleXTo(secondsLeft, duration: 0.2)
    }
    
    public func getFinalTime() -> Double {
        
        return round((100 * seconds) / 100)
    }
    
}