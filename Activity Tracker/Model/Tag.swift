//
//  Tag.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/2/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import RealmSwift
import UIKit

class Tag: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var hueValue: Float = Float(1/(arc4random_uniform(10) + 1))
}
