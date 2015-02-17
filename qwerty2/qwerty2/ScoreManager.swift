//
//  ScoreManager.swift
//  qwerty2
//
//  Created by Chris Lee on 2015-02-11.
//  Copyright (c) 2015 Coffee Digital. All rights reserved.
//

import Foundation
import SpriteKit

public class ScoreManager {
    
    let scoreManagerDefaultsKey = "Leaderboard"
    var score = 0
    
    // Create a function that can be called to save a score
    public func saveScore(score: Int) {
        
        self.score = score
        
//        var leaderboard = NSUserDefaults.standardUserDefaults().objectForKey(self.scoreManagerDefaultsKey) as? NSDictionary ?? NSMutableDictionary()
//        var leaderboardMDict = leaderboard.mutableCopy() as NSMutableDictionary
//        
//        if let highestScore = leaderboard[level] as? Int {
//            leaderboardMDict.setValue(highestScore < score ? score: highestScore, forKey: "Level \(level)")
//        }
//        else {
//            leaderboardMDict.setValue(score, forKey: "Level \(level)")
//        }
//        
//        NSUserDefaults.standardUserDefaults().setObject(leaderboardMDict, forKey: self.scoreManagerDefaultsKey)
//        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    public func getScoreDict() -> NSNumber {
        return self.score
//        return NSUserDefaults.standardUserDefaults().objectForKey("Score") as? NSDictionary ?? NSMutableDictionary()
    }
    
//    public func getScoreForLevel(level: Int) -> Int? {
//        var leaderboard = getScoreDict()
//        return leaderboard["Level \(level)"] as? Int
//    }
}