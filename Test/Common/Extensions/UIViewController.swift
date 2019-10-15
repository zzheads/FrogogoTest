//
//  UIViewController.swift
//  Test
//
//  Created by Алексей Папин on 15.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import UIKit

extension UIViewController {
    public func show(error: Error, completion: (() -> Void)? = nil) {
        let controller = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in completion?() }
        controller.addAction(okAction)
        self.present(controller, animated: true, completion: nil)
    }
}
