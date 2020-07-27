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
    
    private lazy var viewModel = EventsViewModel(interactor: EventsInteractor())
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchEvents()
    }
}
