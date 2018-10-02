//
//  Tag.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/2/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import UIKit

class Tag: NSObject {
    var name: String
    var color: UIColor
    
    init(name: String) {
        self.name = name
        
        let randomNumer = CGFloat(1/(arc4random_uniform(10) + 1))
        self.color = UIColor(hue: randomNumer, saturation: 1, brightness: 1 - randomNumer, alpha: 1)
        
        super.init()
    }
}
