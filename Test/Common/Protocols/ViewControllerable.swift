//
//  UINavigationController.swift
//  Test
//
//  Created by Алексей Папин on 14.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import UIKit

protocol ViewControllerable: class {
    static func storyBoardName() -> String
}

extension ViewControllerable where Self: UIViewController {
    static func create() -> Self {
        let storyboard = self.storyboard()
        let className = NSStringFromClass(Self.self)
        let finalClassName = className.components(separatedBy: ".").last!
        
        let viewControllerId = finalClassName
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerId)
        
        return viewController as! Self
    }
    
    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: storyBoardName(), bundle: nil)
    }
}
