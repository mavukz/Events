//
//  EventDetailsViewController.swift
//  Events
//
//  Created by Luntu on 2020/07/28.
//  Copyright © 2020 Luntu. All rights reserved.
//

import UIKit

class EventDetailsViewController: BaseViewController {
    
    private var dataModel: EventsDataModel!
    private lazy var viewModel = EventDetailsViewModel(delegate: self,
                                                       dataModel: dataModel,
                                                       interactor: EventsInteractor())
    
    func populate(with dataModel: EventsDataModel) {
        self.dataModel = dataModel
    }
    
    override func refreshViewcontents() {
        
    }
}
