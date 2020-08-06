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
    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private var imageCollectionViewHeightConstraint: NSLayoutConstraint!
    
    private var dataModel: EventsDataModel!
    private lazy var viewModel = EventDetailsViewModel(delegate: self,
                                                       dataModel: dataModel,
                                                       interactor: EventsInteractor())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        loadingIndicator.startAnimating()
        viewModel.fetchEvent()
        viewModel.fetchImageForEvent()
        configureCollectionViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func refreshViewContents() {
        DispatchQueue.main.async {
            self.showFirstSegment()
            self.loadingIndicator.stopAnimating()
            self.configureUI()
        }
    }
    
    override func setImage(at indexPath: IndexPath?, with data: Data) {
        DispatchQueue.main.async {
            if let index = indexPath {
                let cell = self.imageCollectionView.cellForItem(at: index) as? EventCollectionViewCell
                cell?.setImageView(with: data)
            } else {
                self.detailedImageView.image = UIImage(data: data)
            }
        }
    }
    
    override func showErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
        super.showErrorMessage(message)
    }
    
    func populate(with dataModel: EventsDataModel) {
        self.dataModel = dataModel
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        switch index {
        case 0:
            showFirstSegment()
        case 1:
            showSecondSegment()
        default:
            return
        }
    }
    
    // MARK: - Private
    
    private func showFirstSegment() {
        imageCollectionView.isHidden = true
        detailedStackView.isHidden = false
    }
    
    private func showSecondSegment() {
        imageCollectionView.isHidden = false
        //hack please fix autolayout
        imageCollectionViewHeightConstraint.constant = imageCollectionView.superview!.frame.size.height
        detailedStackView.isHidden = true
    }
    
    private func configureUI() {
        titleAndStatusView.isHidden = !viewModel.isLive
        titleLabel.text = viewModel.title
        monthLabel.text = viewModel.month
        dayLabel.text = viewModel.day
        bottomTitleLabel.text = viewModel.title
        descriptionLabel.text = ""
    }
    
    private func configureCollectionViewCells() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
}

extension EventDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        viewModel.fetchImageForEvent(at: indexPath)
        return cell
    }
}
