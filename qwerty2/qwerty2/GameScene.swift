//
//  GameScene2.swift
//  qwerty2
//
//  Created by Chris Lee on 2014-12-18.
//  Copyright (c) 2014 Coffee Digital. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView!) {
        println("We are at the new scene")
        self.backgroundColor = UIColor(red: 81/255, green: 150/255, blue: 111/255, alpha: 1.0)
    }
}
