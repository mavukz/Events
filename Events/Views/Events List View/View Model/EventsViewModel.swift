//
//  EventsViewModel.swift
//  Events
//
//  Created by Luntu on 2020/07/27.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

protocol EventsViewModelDelegate: NSObjectProtocol {
    func refreshViewcontents()
    func showErrorMessage(_ message: String)
}

class EventsViewModel {
    
    private weak var delegate: EventsViewModelDelegate?
    private let interactor: EventsBoundary
    private var events = [[EventsDataModel]]()
    private var eventItems = [[EventDetailItem]]()
    private let headerTitles = ["Live Event(s)",
                                "Upcoming Event(s)"];
    
    init(delegate: EventsViewModelDelegate,
        interactor: EventsBoundary) {
        self.delegate = delegate
        self.interactor = interactor
    }
    
    var numberOfSections: Int {
        return events.count
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        if eventItems.count > section {
            return events[section].count
        }
        return -1
    }
    
    func event(at indexPath: IndexPath) -> EventDetailItem? {
        if eventItems.count > indexPath.section {
            let eventItemsInSection = eventItems[indexPath.section]
            if eventItemsInSection.count > indexPath.row {
             return eventItemsInSection[indexPath.row]
            }
        }
        return nil
    }
    
    func title(for section: Int) -> String {
        if headerTitles.count > section {
            return headerTitles[section]
        }
        return ""
    }
    
    func fetchEvents() {
        interactor.fetchEvents(successBlock: { [weak self] response in
            self?.delegate?.refreshViewcontents()
        }) { [weak self] error in
            self?.delegate?.showErrorMessage(error.localizedDescription)
        }
    }
    
    private func processEvents(from events: [EventsDataModel]) {
        for event in events {
//             if from date == now and toDate < now add to section 0 for live events else add to section 2 for upcoming events
            
        }
    }
}
