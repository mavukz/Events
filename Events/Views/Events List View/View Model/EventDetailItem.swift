//
//  EventDetailItem.swift
//  Events
//
//  Created by Luntu on 2020/07/28.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

enum EventType {
    case live
    case upcoming
    case unknown
}

struct EventDetailItem {
    
    var title: String
    var location: String
    var startDate: Date
    var endDate: Date
    var eventType: EventType!
    
    init(title: String,
         location: String,
         startDate: Date,
         endDate: Date) {
        self.title = title
        self.location = location
        self.startDate = startDate
        self.endDate = endDate
        configureEventType()
    }
    
    private mutating func configureEventType() {
        eventType = (Date() >= startDate && Date() < endDate) ? .live : .upcoming
    }
}
