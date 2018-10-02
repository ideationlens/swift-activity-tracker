//
//  Entry.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/2/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import Foundation

class Entry: NSObject {
    let activity: Activity
    var value: Int
    //createdDate
    
    init(activity: Activity, value: Int) {
        self.activity = activity
        self.value = value
        super.init()
    }
    
}
