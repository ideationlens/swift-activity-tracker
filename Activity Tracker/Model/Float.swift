//
//  Float.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 11/7/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import Foundation

extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}

extension Float {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
