//
//  Activity.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/2/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import Foundation
import RealmSwift

class Activity: Object {
    
    // MARK: PROPERTIES
    
    @objc dynamic var name: String = "Name goes here"
    let tags = List<Tag>()
    
    @objc dynamic var entryType = EntryType.plusOneCounter.rawValue
    var entryTypeEnum: EntryType {
        get { return EntryType(rawValue: entryType)! }
        set { entryType = newValue.rawValue }
    }
    
    @objc dynamic var recurrenceType: Int = 0
    var recurrenceTypeEnum: RecurrenceType {
        get { return RecurrenceType(rawValue: recurrenceType)! }
        set { recurrenceType = newValue.rawValue }
    }
    
    @objc dynamic var reportType: Int = 0
    var reportTypeEnum: ReportType {
        get { return ReportType(rawValue: reportType)! }
        set { reportType = newValue.rawValue }
    }
    
    @objc dynamic var units: String = "Count"
    @objc dynamic var isArchived: Bool = false
    
    let entries = List<Entry>()
    
    // MARK: - METHODS
    
    
//    var name: String
//    var tags: [Tag]
//    let entryType: EntryType
//    var recurrenceType: RecurrenceType
//    var reportType: ReportType
//    var units: String
//    var isArchived: Bool
//
//    init(name: String
//             ,tags: [Tag]
//             ,entryType: EntryType = .plusOneCounter
//             ,recurrenceType: RecurrenceType = .immediately
//             ,reportType: ReportType = .count
//             ,units: String = "Count")
//    {
//        self.name = name
//        self.tags = tags
//        self.entryType = entryType
//        self.recurrenceType = recurrenceType
//        self.reportType = reportType
//        self.units = units
//        self.isArchived = false
//
//        super.init()
//    }
//
    
}
