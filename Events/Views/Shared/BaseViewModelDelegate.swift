//
//  BaseViewModelDelegate.swift
//  Events
//
//  Created by Luntu on 2020/08/05.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

protocol BaseViewModelDelegate: NSObjectProtocol {
    func refreshViewcontents()
    func showErrorMessage(_ message: String)
}
