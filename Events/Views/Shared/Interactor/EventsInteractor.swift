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
    
    func fetchEvent(with id: String,
                    successBlock success: @escaping FetchEventSuccess,
                    failureBlock failure: @escaping BoundaryFailureBlock) {
        let requestBody = "GetEvents/\(id)/11614155/"
        self.post(with: requestBody,
                  successBlock: { payData in
                    if let response: EventsDataModel = EventsDataModel.model(from: payData) {
                        success(response)
                    }
        }) { error in
            failure(error)
        }
    }
    func fetchImage(with url: String,
                    successBlock success: @escaping FetchImageSuccess,
                    failureBlock failure: @escaping BoundaryFailureBlock) {
        self.post(withImageURL: url,
                  successBlock: { data in
                    success(data)
        }) { error in
            failure(error)
        }
    }
}
