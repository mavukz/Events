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
    
    // MARK: - Interactor
    
    func fetchEvent() {
        interactor.fetchEvent(with: dataModel.eventID,
                              successBlock: { [weak self] response in
                                print(response)
                                self?.delegate?.refreshViewcontents()
        }) { [weak self] error in
            self?.delegate?.showErrorMessage(error.localizedDescription)
        }
    }
}
