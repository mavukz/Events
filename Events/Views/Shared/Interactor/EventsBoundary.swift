//
//  EventsBoundary.swift
//  Events
//
//  Created by Luntu on 2020/07/27.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

typealias FetchEventsSuccess = (_ events: [EventsDataModel]) -> Void
typealias FetchEventSuccess = (_ event: EventsDataModel) -> Void
typealias FetchImageSuccess = (_ imageData: Data) -> Void


protocol EventsBoundary {
    
    func fetchEvents(successBlock success: @escaping FetchEventsSuccess,
                     failureBlock failure: @escaping BoundaryFailureBlock)
    
    func fetchEvent(with id: String,
                    successBlock success: @escaping FetchEventSuccess,
                    failureBlock failure: @escaping BoundaryFailureBlock)
    
    func fetchImage(with url: String,
                    successBlock success: @escaping FetchImageSuccess,
                    failureBlock failure: @escaping BoundaryFailureBlock)
}
