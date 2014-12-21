// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var timerBar = SKSpriteNode()
var startTime = NSTimeInterval()
var timer = NSTimer()
var gameTime: Double = 10.0

func didMoveToView(view: SKView) {
    backgroundColor = UIColor(red: 81/255, green: 150/255, blue: 111/255, alpha: 1.0)
    
    timerBar.position = CGPoint(x: 0, y: (CGRectGetMaxY(self.frame)))
    timerBar.color = SKColor .blueColor()
    timerBar.anchorPoint = CGPoint(x: 0,y: 1)
    timerBar.size.width = (self.size.width)
    timerBar.size.height = 40
    addChild(timerBar)
    
    startGame()
}

func startGame() {
    
    let aSelector : Selector = "updateTime"
    timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: aSelector, userInfo: nil, repeats: true)
    startTime = NSDate.timeIntervalSinceReferenceDate()
    
}

func updateTime() {
    var currentTime = NSDate.timeIntervalSinceReferenceDate()
    var elapsedTime = currentTime - startTime
    var seconds = gameTime - elapsedTime
    if seconds > 0 {
        elapsedTime -= NSTimeInterval(seconds)
        println("\(Int(seconds))")
    } else {
        timer.invalidate()
        
        var secondsLeft = CGFloat(seconds / gameTime)
        
        self.timerBar.size.width = SKAction.scale
    }
}