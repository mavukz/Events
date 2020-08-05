//
//  EventDetailsViewController.swift
//  Events
//
//  Created by Luntu on 2020/07/28.
//  Copyright © 2020 Luntu. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
 
    private var eventItem: EventDetailItem!
    
    func populate(with eventItem: EventDetailItem) {
        self.eventItem = eventItem
    }
}
