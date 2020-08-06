//
//  EventsDetailedTableViewCell.swift
//  Events
//
//  Created by Luntu on 2020/07/28.
//  Copyright © 2020 Luntu. All rights reserved.
//

import UIKit

class EventsDetailedTableViewCell: UITableViewCell {
    
    @IBOutlet private var topDateLabel: UILabel!
    @IBOutlet private var eventImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var detailedView: UIView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var checkinButton: UIButton!
    
    func populate(with eventItem: EventDetailItem) {
        topDateLabel.text = Date.string(date: eventItem.startDate,
                                        format: DateFormats.SimpleDateFormat)
        titleLabel.text = eventItem.title
        detailedView.backgroundColor = eventItem.eventType == .live ? UIColor.green : UIColor.systemGray
        descriptionLabel.text = "\(eventItem.startDate)\n\(eventItem.location)\n"
        checkinButton.backgroundColor = eventItem.eventType == .live ? UIColor.systemGreen : UIColor.lightGray
    }
    
    func setImageView(with data: Data) {
        eventImageView.image = UIImage(data: data)
    }
}
