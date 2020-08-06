//
//  BaseViewController.swift
//  Events
//
//  Created by Luntu on 2020/08/05.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, BaseViewModelDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
    }
    
    func showErrorMessage(_ message: String) {
        DispatchQueue.main.async {
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
    }
    
    func refreshViewContents() {
        //hide shared loading indicator
    }
    
    func setImage(at indexPath: IndexPath?,
                  with data: Data) {
    }
}
