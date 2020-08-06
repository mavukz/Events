//
//  EventDetailsViewModel.swift
//  Events
//
//  Created by Luntu on 2020/08/05.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

protocol EventDetailsViewModelDelegate: BaseViewModelDelegate {
    func fetchMediaSuccess()
}

class EventDetailsViewModel {
    
    private weak var delegate: EventDetailsViewModelDelegate?
    private var dataModel: EventsDataModel
    private let interactor: EventsBoundary
    
    init(delegate: EventDetailsViewModelDelegate,
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
    
    var ratingQuestion: String {
        return dataModel.ratingQuestion
    }
    
    var numberOfItems: Int {
        return dataModel.media?.count ?? -1
    }
    
    // MARK: - Interactor
    
    func fetchEvent() {
        interactor.fetchEvent(with: dataModel.eventID,
                              successBlock: { [weak self] response in
                                let oldMedia = self?.dataModel.media
                                //hack use old media as new one fails on deserialise
                                self?.dataModel = response
                                self?.dataModel.media = oldMedia
                                self?.delegate?.refreshViewContents()
        }) { [weak self] error in
            self?.delegate?.showErrorMessage(error.localizedDescription)
        }
    }
    
    func fetchImage() {
        if let url = dataModel.media?.first?.mediaURL {
            interactor.fetchImage(with: url,
                                  successBlock: { [weak self] response in
                                    self?.delegate?.setImage(at: nil, with: response)
            }) { [weak self] error in
                self?.delegate?.showErrorMessage(error.localizedDescription)
            }
        }
    }
    
    func fetchImage(at indexPath: IndexPath) {
        if let media = dataModel.media,
            media.count > indexPath.row {
            let url = media[indexPath.row].mediaURL
            interactor.fetchImage(with: url,
                                  successBlock: { [weak self] response in
                                    self?.delegate?.setImage(at: indexPath,
                                                             with: response)
            }) { [weak self] error in
                self?.delegate?.showErrorMessage(error.localizedDescription)
            }
        }
    }
    
    //Fails to deserialise media response not using it
    func fetchMedia() {
//        interactor.fetchMedia(with: dataModel.eventID,
//                              successBlock: { [weak self] response in
//                                self?.dataModel.media = response
//                                self?.delegate?.fetchMediaSuccess()
//        }) { [weak self] error in
//            self?.delegate?.showErrorMessage(error.localizedDescription)
//        }
        self.delegate?.fetchMediaSuccess()
    }
}
