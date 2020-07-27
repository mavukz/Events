//
//  EventsViewModel.swift
//  Events
//
//  Created by Luntu on 2020/07/27.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

class EventsViewModel {
    
    let interactor: EventsBoundary
    
    init(interactor: EventsBoundary) {
        self.interactor = interactor
    }
    
    func fetchEvents() {
        interactor.fetchEvents(successBlock: { [weak self] response in
            
        }) { [weak self] error in
            
        }
    }
}
