//
//  EventDetailsViewController.swift
//  Events
//
//  Created by Luntu on 2020/07/28.
//  Copyright © 2020 Luntu. All rights reserved.
//

import UIKit

class EventDetailsViewController: BaseViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var titleAndStatusView: UIView!
    @IBOutlet private var segmentedControl: UISegmentedControl!
    @IBOutlet private var detailedImageView: UIImageView!
    @IBOutlet private var monthLabel: UILabel!
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var bottomTitleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var imageCollectionView: UICollectionView!
    
    
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
