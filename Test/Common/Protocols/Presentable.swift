//
//  UINavigationController.swift
//  Test
//
//  Created by Алексей Папин on 14.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import UIKit

protocol Presentable {    
    var viewController: UIViewController { get }
    
    func presentAsNavController()
    func presentAsNavController(from viewController: UIViewController)
    func presentAsNavController(from viewController: UIViewController, animated: Bool)
    
    func present(from viewController: UIViewController)
    func showInContainer(container: UIView, in viewController: UIViewController)
    
    func dismissAsNavController()
}

extension Presentable where Self: UIViewController {
    var viewController: UIViewController {
        return self
    }
    
    func presentAsNavController() {
        let navigation = UINavigationController(rootViewController: viewController)
        AppDelegate.currentWindow.rootViewController = navigation
    }

    func presentAsNavController(from viewController: UIViewController) {
        presentAsNavController(from: viewController, animated: true)
    }
    
    func presentAsNavController(from viewController: UIViewController, animated: Bool) {
        UINavigationController.present(from: viewController, rootVC: self, animated: true)
    }
    
    func present(from viewController: UIViewController) {
        viewController.navigationController?.pushViewController(self, animated: true)
    }
    
    func showInContainer(container: UIView, in viewController: UIViewController) {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self.view)
        
        self.view.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        self.view.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        self.view.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        let bottomConstraint = self.view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        bottomConstraint.priority = UILayoutPriority(900)
        bottomConstraint.isActive = true
        
        viewController.addChild(self)
        self.didMove(toParent: viewController)
    }

    func dismissAsNavController() {
        viewController.navigationController?.dismiss(animated: true, completion: nil)
    }
}
