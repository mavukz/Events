//
//  EventsHeaderCell.swift
//  Events
//
//  Created by Luntu on 2020/07/28.
//  Copyright © 2020 Luntu. All rights reserved.
//

import UIKit

class EventsHeaderCell: UITableViewCell {

    @IBOutlet private var eventCountButton: UIButton!
    @IBOutlet private var eventTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        roundButton()
    }
    
    func populate(with title: String, counter: String) {
        eventTitleLabel.text = title
        eventCountButton.setTitle(counter, for: .normal)
    }
    
    // MARK: - Private
    
    private func roundButton() {
        eventCountButton.layer.cornerRadius = eventCountButton.frame.height / 2
        eventCountButton.layer.masksToBounds = true
    }
}
