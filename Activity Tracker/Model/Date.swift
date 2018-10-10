//
//  Date.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/10/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import Foundation

extension Date {
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        //dateFormatter.dateStyle = .full
        return dateFormatter.string(from: self)
    }
}
