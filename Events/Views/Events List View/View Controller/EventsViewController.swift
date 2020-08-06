//
//  EventsViewController.swift
//  Events
//
//  Created by Luntu on 2020/07/27.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation
import UIKit

class EventsViewController: BaseViewController {
    
    @IBOutlet private var eventsTableView: UITableView!
    @IBOutlet private var loadingIndicatorView: UIActivityIndicatorView!
    
    private lazy var viewModel = EventsViewModel(delegate: self,
                                                 interactor: EventsInteractor())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        loadingIndicatorView.startAnimating()
        viewModel.fetchEvents()
        configureTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "eventDetailsSegue" {
            let eventDetailsScreen = segue.destination as! EventDetailsViewController
            if let dataModel = viewModel.selectedEvent {
                eventDetailsScreen.populate(with: dataModel)
            }
        }
    }
    
    override func refreshViewcontents() {
        DispatchQueue.main.async {
            self.eventsTableView.reloadData()
            self.loadingIndicatorView.stopAnimating()
        }
    }
    
    override func setImage(at indexPath: IndexPath, with data: Data) {
        DispatchQueue.main.async {
            let cell = self.eventsTableView.cellForRow(at: indexPath) as? EventsDetailedTableViewCell
            cell?.setImageView(with: data)
        }
    }
    
    override func showErrorMessage(_ message: String) {
        DispatchQueue.main.sync {
            self.loadingIndicatorView.stopAnimating()
        }
        super.showErrorMessage(message)
    }
    
    // MARK: - Private
    
    private func configureTableView() {
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.register(UINib(nibName: "EventsDetailedTableViewCell", bundle: .main),
                                 forCellReuseIdentifier: "DetailedCell")
        eventsTableView.register(UINib(nibName: "EventsHeaderCell", bundle: .main),
                                 forCellReuseIdentifier: "HeaderCell")
    }
}

// MARK: - UITableViewDelegate

extension EventsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectedEvent(at: indexPath)
        performSegue(withIdentifier: "eventDetailsSegue", sender: self)
    }
}

// MARK: - UITableViewDataSource

extension EventsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedCell") as? EventsDetailedTableViewCell
        if let eventItem = viewModel.event(at: indexPath) {
            cell?.populate(with: eventItem)
            viewModel.fetchImageForEvent(at: indexPath)
            cell?.setNeedsUpdateConstraints()
            cell?.updateConstraintsIfNeeded()
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? EventsHeaderCell
        cell?.populate(with: viewModel.title(at: section),
                       counter: "\(viewModel.numberOfRows(inSection: section))",
            eventType: viewModel.eventType(at: section))
        cell?.setNeedsUpdateConstraints()
        cell?.updateConstraintsIfNeeded()
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(inSection: section)
    }
}
