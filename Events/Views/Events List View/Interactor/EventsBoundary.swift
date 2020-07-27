//
//  EventsBoundary.swift
//  Events
//
//  Created by Luntu on 2020/07/27.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

typealias FetchEventsSuccess = (_ events: [EventsDataModel]) -> Void

protocol EventsBoundary {
    func fetchEvents(successBlock success: @escaping FetchEventsSuccess,
                     failureBlock failure: @escaping BoundaryFailureBlock)
}
