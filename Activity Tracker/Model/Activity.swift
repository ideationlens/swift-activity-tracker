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
            label0 = "Day: \(line)" +  String(result0.format(f: ".0"))
            
            // count - report label 1
            result1 = Float(self.entries.filter("timestamp > %@", Date().addingTimeInterval(-604800)).count)
            label1 = "Week: \(line)" + String(result1.format(f: ".0"))
            
            // count - report label 2
            result2 = Float(self.entries.filter("timestamp > %@", Date().addingTimeInterval(-2419200)).count)
            label2 = "4 Weeks: \(line)" + String(result2.format(f: ".0"))
        
        // change report type
        case ReportType.change:
            // change - report label 0
            result0 = Float(self.entries.filter("timestamp > %@", Date().addingTimeInterval(-86400)).count)
            label0 = "Day: \(line)\(result0.format(f: ".1"))/day"
            
            // change - report label 2
            result2 = Float(self.entries.filter("timestamp > %@", Date().addingTimeInterval(-604800)).count)/7.0
            label2 = "Week: \(line)\(result2.format(f: ".1"))/day"
            
            // change - report label 1
            result1 = result0 - result2
            if result0 > result2 {
                label1 = "Delta: \(line)+\(result1.format(f: ".1"))/day"
            } else {
                label1 = "Delta: \(line)\(result1.format(f: ".1"))/day"
            }
            
        // streak report type
        case ReportType.streak:
            // create streak array, where each element is one consectuive streak count
            var streaks = [0]
            var streakIndex = 0
            let minDate = self.entries.min(ofProperty: "timestamp") as Date?

            // iterate through each day since first entry, while also iterating through each entry
            if minDate != nil {
                let calendar = Calendar.current
                var streakDate = minDate!
                for entry in self.entries {
                    // dates are in the same day, then add one to current streak
                    if calendar.isDate(streakDate, inSameDayAs: entry.timestamp) {
                        streaks[streakIndex] += 1
                        streakDate = Calendar.current.date(byAdding: .day, value: 1, to: streakDate)!
                        
                    // else if entry date is greater than the streak date, then start new streak
                    } else if streakDate <  entry.timestamp {
                        streaks.append(1)
                        streakIndex += 1
                        streakDate = entry.timestamp
                        streakDate = calendar.date(byAdding: .day, value: 1, to: streakDate)!
                    }
                }
            }
            //print(streaks)
            
            var streakSum = 0
            for streak in streaks {streakSum += streak}
            let streakAverage: Float = Float(streakSum) / Float(streaks.count)
            
            label0 = "Current: \(line)\(streaks.last ?? 0)"
            label1 = "Best: \(line)\(streaks.max() ?? 0)"
            label2 = "Average: \(line)\(streakAverage.format(f: ".1"))"
            
        // time passed report type
        case ReportType.timePassed:
            // create array of days elapsed between entries
            var times = [0]
            let calendar = NSCalendar.current
            
            if self.entries.count > 0 {
                let minDate = self.entries.min(ofProperty: "timestamp") as Date?
                let totalDaysElapsed = calendar.dateComponents([.day], from: minDate!, to: Date()).day!
                
                if self.entries.count > 1 {
                    times = []
                    
                    for n in 1...self.entries.count - 1 {
                        let date1 = calendar.startOfDay(for: self.entries[n-1].timestamp)
                        let date2 = calendar.startOfDay(for: self.entries[n].timestamp)
                        
                        // if the two entries occur on different days, then append the difference in days to array
                        if !calendar.isDate(date1, inSameDayAs: date2) {
                            let timeComponents = calendar.dateComponents([.day], from: date1, to: date2)
                            times.append(timeComponents.day!)
                        }
                    }
                    
                    let date1 = calendar.startOfDay(for: self.entries.last!.timestamp)
                    let date2 = calendar.startOfDay(for: Date())
                    let timeComponents = calendar.dateComponents([.day], from: date1, to: date2)
                    times.append(timeComponents.day!)
                    
                } else {
                    times = [totalDaysElapsed]
                }
            }
            print(times)
            
            let sortedTimes = times.sorted()
            let count = times.count
            var median = Float(sortedTimes[count / 2])
            if count % 2 == 0 {
                median = (median + Float(sortedTimes[count / 2 - 1])) / 2.0
            }
            
            label0 = "Current: \(line)\(times.last ?? 0) days"
            label1 = "Median: \(line)\(median.format(f: ".1")) days"
            if let maxTime = times.max() {
                label2 = "Max: \(line)\(maxTime) days"
            } else {
                label2 = " "
            }
            
        }
        
        return (label0, label1, label2)
    }
    
}
