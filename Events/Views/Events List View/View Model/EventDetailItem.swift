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
}

struct EventDetailItem {
    
    var title: String
    var location: String
    var startDate: Date
    var endDate: Date
    var eventType: EventType
}
