//
//  Activity.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/2/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import Foundation

class Activity: NSObject {
    var name: String
    var tags: [Tag]
    let entryType: EntryType
    var recurrenceType: RecurrenceType
    var reportType: ReportType
    var units: String
    var isArchived: Bool
    
    init(name: String
             ,tags: [Tag]
             ,entryType: EntryType = .plusOneCounter
             ,recurrenceType: RecurrenceType = .immediately
             ,reportType: ReportType = .count
             ,units: String = "Count")
    {
        self.name = name
        self.tags = tags
        self.entryType = entryType
        self.recurrenceType = recurrenceType
        self.reportType = reportType
        self.units = units
        self.isArchived = false
        
        super.init()
    }
    
    
}
