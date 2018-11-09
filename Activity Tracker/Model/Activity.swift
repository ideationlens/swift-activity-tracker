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
    
    func getReportLabels(for reportType: ReportType? = nil, onSingleLine: Bool = true) -> (String, String, String) {
        // return labels
        var label0 = ""
        var label1 = ""
        var label2 = ""
        
        // query results
        var result0: Float = 0.0
        var result1: Float = 0.0
        var result2: Float = 0.0
        
        // report type
        var selectedReportType: ReportType!
        selectedReportType = reportType == nil ? self.reportTypeEnum : reportType
        
        // layout
        let line = onSingleLine ? "" : "\n"
        
        switch selectedReportType! {
        // count report type
        case ReportType.count:
            // count - report label 0
            result0 = Float(self.entries.filter("timestamp > %@", Date().addingTimeInterval(-86400)).count)
            label0 = "Last 24 hours: \(line)" +  String(result0)
            
            // count - report label 1
            result1 = Float(self.entries.filter("timestamp > %@", Date().addingTimeInterval(-604800)).count)
            label1 = "Last 7 days: \(line)" + String(result1)
            
            // count - report label 2
            result2 = Float(self.entries.filter("timestamp > %@", Date().addingTimeInterval(-2419200)).count)
            label2 = "Last 4 weeks: \(line)" + String(result2)
        
        // change report type
        case ReportType.change:
            // change - report label 0
            result0 = Float(self.entries.filter("timestamp > %@", Date().addingTimeInterval(-86400)).count)
            label0 = "Last 24 hours: \(line)\(result1.format(f: ".1"))/day"
            
            // change - report label 2
            result2 = Float(self.entries.filter("timestamp > %@", Date().addingTimeInterval(-604800)).count)/7.0
            label2 = "Last 7 days: \(line)\(result2.format(f: ".1"))/day"
            
            // change - report label 1
            result1 = result0 - result2
            if result0 > result2 {
                label1 = "Delta: \(line)+\(result1.format(f: ".1"))/day"
            } else {
                label1 = "Delta: \(line)\(result1.format(f: ".1"))/day"
            }
            
        // streak report type
        case ReportType.streak:
            label0 = "Current Streak: \(line)8"
            label1 = "Best Streak: \(line)12"
            label2 = "Average: \(line)7"
            
        // time passed report type
        case ReportType.timePassed:
            label0 = "Current: \(line)10 days"
            label1 = "Average: \(line)14 days"
            label2 = " "
        }
        
        return (label0, label1, label2)
    }
    
}
