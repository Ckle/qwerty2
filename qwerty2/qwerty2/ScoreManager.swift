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
    
    // Create a function that can be called to save a score
    class func saveScore(score: Int, forLevel level: Int) {
        
        var leaderboard = NSUserDefaults.standardUserDefaults().objectForKey("LeaderBoard") as? NSDictionary ?? NSMutableDictionary()
        var leaderboardMDict = leaderboard.mutableCopy() as NSMutableDictionary
        
        if let highestScore = leaderboard[level] as? Int {
            leaderboardMDict.setValue(highestScore < score ? score: highestScore, forKey: "Level \(level)")
        }
        else {
            leaderboardMDict.setValue(score, forKey: "Level \(level)")
        }
        
        NSUserDefaults.standardUserDefaults().setObject(leaderboardMDict, forKey: "LeaderBoard")
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    class func getScoreDict() -> NSDictionary {
        return NSUserDefaults.standardUserDefaults().objectForKey("Leaderboard") as? NSDictionary ?? NSMutableDictionary()
    }
    class func getScoreForLevel(level: Int) -> Int? {
        var leaderboard = getScoreDict()
        return leaderboard["Level \(level)"] as? Int
    }
//    class func getAllHighScores() -> String? {
//        
//    }
}