//
//  EventsInteractor.swift
//  Events
//
//  Created by Luntu on 2020/07/27.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

class EventsInteractor: WebServicesManager, EventsBoundary {
    
    func fetchEvents(successBlock success: @escaping FetchEventsSuccess,
                     failureBlock failure: @escaping BoundaryFailureBlock) {
        let requestBody = "GetEvents/11614155/1234"
        self.post(with: requestBody,
                  successBlock: { payData in
                    if let events = payData["Events"] as? [[String: Any]] {
                        let response: [EventsDataModel] = EventsDataModel.model(from: events) ?? [EventsDataModel]()
                        success(response)
                    }
        }) { error in
            failure(error)
        }
    }
}
