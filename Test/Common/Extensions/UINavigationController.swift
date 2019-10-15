//
//  UINavigationController.swift
//  Test
//
//  Created by Алексей Папин on 14.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import UIKit

extension UINavigationController {
    static func present(from vc: UIViewController, rootVC: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        let nvc = UINavigationController(rootViewController: rootVC)
        vc.present(nvc, animated: animated, completion: completion)
    }
}
