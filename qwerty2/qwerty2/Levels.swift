//
//  Levels.swift
//  qwerty2
//
//  Created by Chris Lee on 2015-01-02.
//  Copyright (c) 2015 Coffee Digital. All rights reserved.
//

import Foundation
import UIKit

public class Levels {
    
    // **USING THE FUNCTION THAT IS CALLED IN LEVEL SELECT SCENE, HAVE AN ARRAY OF CONTENT THAT WILL BE CALLED INSIDE GAMESCENE WHEN DRAWING THE SCENE. INSIDE GAMESCENE WILL CALL THE CONTENT ACCORDING TO THE CURRENT LEVEL ASSIGNED TO THE PUBLIC VARIABLE IN THAT CLASS.
    let levelNum: Int
    let levelTimeMin: Int
    let levelTimeMax: Int
    
    init(levelNum: Int, levelTimeMin: Int, levelTimeMax: Int) {
        self.levelNum = levelNum
        self.levelTimeMin = levelTimeMin
        self.levelTimeMax = levelTimeMax
        
    }
}

public class LevelManager {
    
    
}
