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
    private var currentEventItem: EventDetailItem?
    
    init(delegate: EventsViewModelDelegate,
         interactor: EventsBoundary) {
        self.delegate = delegate
        self.interactor = interactor
    }
    
    var numberOfSections: Int {
        return events.count
    }
    
    var selectedEventItem: EventDetailItem {
        return currentEventItem ?? EventDetailItem()
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
    
    func title(at section: Int) -> String {
        if headerTitles.count > section {
            return headerTitles[section]
        }
        return ""
    }
    
    func eventType(at section: Int) -> EventType {
        return section == 0 ? .live : .upcoming
    }
    
    
    func selectedEventItem(at indexPath: IndexPath) {
        if eventItems.count > indexPath.section {
            let eventItemsInSection = eventItems[indexPath.section]
            if eventItemsInSection.count > indexPath.row {
                currentEventItem = eventItemsInSection[indexPath.row]
            }
        }
    }
    
    // MARK: - Interactor
    
    func fetchEvents() {
        interactor.fetchEvents(successBlock: { [weak self] response in
            self?.processEvents(from: response)
            self?.delegate?.refreshViewcontents()
        }) { [weak self] error in
            self?.delegate?.showErrorMessage(error.localizedDescription)
        }
    }
    
    // MARK: - Private
    
    private func processEvents(from responseEvents: [EventsDataModel]) {
        var liveEvents = [EventsDataModel]()
        var upcomingEvents = [EventsDataModel]()
        for event in responseEvents {
            if Date() >= event.fromDate && Date() < event.toDate {
                liveEvents.append(event)
            } else if event.fromDate > Date() {
                upcomingEvents.append(event)
            }
        }
        
        if !liveEvents.isEmpty {
            events.append(liveEvents)
            createEventItems(from: liveEvents)
        }
        
        if !upcomingEvents.isEmpty {
            events.append(upcomingEvents)
            createEventItems(from: upcomingEvents)
        }
    }
    
    private func createEventItems(from events: [EventsDataModel]) {
        let items = events.map {
            EventDetailItem(title: $0.title,
                            location: $0.location,
                            startDate: $0.fromDate,
                            endDate: $0.toDate)
        }
        eventItems.append(items)
    }
}
