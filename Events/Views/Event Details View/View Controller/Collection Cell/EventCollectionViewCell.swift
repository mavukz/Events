//
//  EventCollectionViewCell.swift
//  Events
//
//  Created by Luntu on 2020/08/06.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation
import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var imageView: UIImageView!
    
    func setImageView(with data: Data) {
        imageView.image = UIImage(data: data)
    }
}
