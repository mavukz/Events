//
//  EventsViewController.swift
//  Events
//
//  Created by Luntu on 2020/07/27.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation
import UIKit

class EventsViewController: UIViewController {
    
    @IBOutlet private var eventsTableView: UITableView!
    @IBOutlet private var loadingIndicatorView: UIActivityIndicatorView!
    
    private lazy var viewModel = EventsViewModel(delegate: self,
                                                 interactor: EventsInteractor())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicatorView.startAnimating()
        viewModel.fetchEvents()
        configureTableView()
    }
    
    // MARK: - Private
    
    private func configureTableView() {
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.register(UINib(nibName: "EventsDetailedTableViewCell", bundle: .main),
                                 forCellReuseIdentifier: "DetailedCell")
        eventsTableView.register(UINib(nibName: "EventsHeaderCell", bundle: .main),
                                 forHeaderFooterViewReuseIdentifier: "HeaderCell")
    }
}

// MARK: - EventsViewModelDelegate

extension EventsViewController: EventsViewModelDelegate {
   
    func showErrorMessage(_ message: String) {
        //handle error with dialog or failure screen
    }
    
    func refreshViewcontents() {
        DispatchQueue.main.async {
            self.eventsTableView.reloadData()
            self.loadingIndicatorView.stopAnimating()
        }
    }
}

// MARK: - UITableViewDelegate

extension EventsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension EventsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedCell") as? EventsDetailedTableViewCell
        if let eventItem = viewModel.event(at: indexPath) {
            cell?.populate(with: eventItem)
            cell?.setNeedsUpdateConstraints()
            cell?.updateConstraintsIfNeeded()
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? EventsHeaderCell
        cell?.populate(with: viewModel.title(for: section), counter: "\(viewModel.numberOfRows(inSection: section))")
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(inSection: section)
    }
}
