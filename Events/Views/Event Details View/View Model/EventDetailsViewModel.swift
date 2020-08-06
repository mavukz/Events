//
//  EventDetailsViewModel.swift
//  Events
//
//  Created by Luntu on 2020/08/05.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

class EventDetailsViewModel {
    
    private weak var delegate: BaseViewModelDelegate?
    private let dataModel: EventsDataModel
    private let interactor: EventsBoundary
    
    init(delegate: BaseViewModelDelegate,
         dataModel: EventsDataModel,
         interactor: EventsBoundary) {
        self.delegate = delegate
        self.dataModel = dataModel
        self.interactor = interactor
    }
    
    var title: String {
        return dataModel.title
    }
    
    var month: String? {
        return Date.string(date: dataModel.fromDate,
                           format: DateFormats.Month)
    }
    
    var day: String? {
        return Date.string(date: dataModel.fromDate,
                           format: DateFormats.Day)
    }
    
    var isLive: Bool {
        return (Date() >= dataModel.fromDate && Date() < dataModel.toDate)
    }
    
    var numberOfItems: Int {
        return dataModel.media?.count ?? -1
    }
    
    // MARK: - Interactor
    
    func fetchEvent() {
        interactor.fetchEvent(with: dataModel.eventID,
                              successBlock: { [weak self] response in
                                print(response)
                                self?.delegate?.refreshViewContents()
        }) { [weak self] error in
            self?.delegate?.showErrorMessage(error.localizedDescription)
        }
    }
    
    func fetchImageForEvent(at indexPath: IndexPath? = nil) {
        if let url = dataModel.media?.first?.mediaURL {
            interactor.fetchImage(with: url,
                                  successBlock: { [weak self] response in
                                    self?.delegate?.setImage(at: indexPath, with: response)
            }) { [weak self] error in
                self?.delegate?.showErrorMessage(error.localizedDescription)
            }
        }
    }
}
