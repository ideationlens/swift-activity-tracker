//
//  ReportType.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/2/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import Foundation

enum ReportType: Int {
    case count = 0, change, streak, timePassed
    
    static let string: [ReportType: String] = [.count: "Count", .change: "Change", .streak: "Streak", .timePassed: "Time Passed"]
}

// MARK: - CUSTOM STRING CONVERTIBLE

extension ReportType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .count: return "Counts"
        case .change: return "Change"
        case .streak: return "Streaks"
        case .timePassed: return "Time Elapsed"
        }
    }
    
    // Definition

    public var definition: String {
        switch self {
        case .count: return "Counts - displays totals for today, the past 7 days and 30 days."
        case .change: return "Change - displays current week, last week and the difference."
        case .streak: return "Streaks - displays your current streak and best streak."
        case .timePassed: return "Time Elapsed - displays days since last occurance and average days between occurences"
        }
    }
}
