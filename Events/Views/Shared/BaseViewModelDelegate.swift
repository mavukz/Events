//
//  BaseViewModelDelegate.swift
//  Events
//
//  Created by Luntu on 2020/08/05.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

protocol BaseViewModelDelegate: NSObjectProtocol {
    func refreshViewContents()
    func showErrorMessage(_ message: String)
    // Only adding this here since its shared on both views
    func setImage(at indexPath: IndexPath?,
                  with data: Data)
}
