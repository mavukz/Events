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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "eventDetailsSegue" {
            let eventDetailsScreen = segue.destination as! EventDetailsViewController
            eventDetailsScreen.populate(with: viewModel.selectedEventItem)
        }
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

// MARK: - EventsViewModelDelegate

extension EventsViewController: EventsViewModelDelegate {
    
    func showErrorMessage(_ message: String) {
        let alertViewController = UIAlertController(title: "Error",
                                                    message: message,
                                                    preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK",
                                        style: .default) { _ in
                                            alertViewController.dismiss(animated: true)
                                            self.navigationController?.popViewController(animated: true)
        }
        alertViewController.addAction(alertAction)
        self.present(alertViewController, animated: true)
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
        viewModel.selectedEventItem(at: indexPath)
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
