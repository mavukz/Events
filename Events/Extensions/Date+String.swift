//
//  DateExtensions.swift
//  Events
//
//  Created by Luntu on 2020/08/04.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

struct DateFormats {
    static let LongDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    static let SimpleDateFormat = "dd MMMM yyyy"
    static let SimpleDateFormatWithDayName = "EEEE, d MMM yyyy"
    static let TimeFormat = "hh:mm a"
    
}

struct EventsDateFormatter {
    
    static let sharedInstance = EventsDateFormatter()
    let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_ZA")
    }
}

extension Date {
    
    static func from(string: String, format: String) -> Date? {
        EventsDateFormatter.sharedInstance.dateFormatter.dateFormat = format
        return EventsDateFormatter.sharedInstance.dateFormatter.date(from: string)
    }
    
    static func string(date: Date, format: String) -> String? {
        EventsDateFormatter.sharedInstance.dateFormatter.dateFormat = format
        return EventsDateFormatter.sharedInstance.dateFormatter.string(from: date)
    }
}
