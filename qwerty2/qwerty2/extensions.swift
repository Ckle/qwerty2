//
//  extensions.swift
//  qwerty2
//
//  Created by Chris Lee on 2014-12-30.
//  Copyright (c) 2014 Coffee Digital. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

extension String {
    subscript (i: Int) -> String {
        return String(Array(self)[i])
    }
}
