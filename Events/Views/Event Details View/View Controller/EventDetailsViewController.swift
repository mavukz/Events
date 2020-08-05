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
    @IBOutlet private var detailedStackView: UIStackView!
    
    private var dataModel: EventsDataModel!
    private lazy var viewModel = EventDetailsViewModel(delegate: self,
                                                       dataModel: dataModel,
                                                       interactor: EventsInteractor())
    
    func populate(with dataModel: EventsDataModel) {
        self.dataModel = dataModel
    }
    
    override func refreshViewcontents() {
        
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        switch index {
        case 0:
            imageCollectionView.isHidden = true
            detailedStackView.isHidden = false
            titleAndStatusView.isHidden = false
        case 1:
            imageCollectionView.isHidden = false
            detailedStackView.isHidden = true
            titleAndStatusView.isHidden = true
        default:
            return
        }
    }
}

extension EventDetailsViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}
