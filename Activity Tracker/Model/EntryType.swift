//
//  File.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/2/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import Foundation

enum EntryType: Int {
    case checkbox = 0, plusOneCounter //, keypad, yesNo
}

// MARK: - CUSTOM STRING CONVERTIBLE

extension EntryType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .checkbox: return "Checkbox"
        case .plusOneCounter: return "Counter"
//        case .keypad: return "Keypad"
//        case .yesNo: return "Yes/No"
        }
    }
    
    public var definition: String {
        switch self {
        case .checkbox: return "Checkbox - creates an entry when checked."
        case .plusOneCounter: return "Counter - creates an entry with a pre-determined value, like +1."
//        case .keypad: return "Keypad - let's you enter a number."
//        case .yesNo: return "Yes / No - let's you submit a 'yes' or 'no'."
        }
    }
    
}
