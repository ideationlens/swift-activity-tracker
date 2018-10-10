//
//  Entry.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/2/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import Foundation
import RealmSwift

class Entry: Object {
    @objc dynamic var value: Int = 1
    @objc dynamic var timestamp: Date = Date()
    var parentActivity = LinkingObjects(fromType: Activity.self, property: "entries")  
}
