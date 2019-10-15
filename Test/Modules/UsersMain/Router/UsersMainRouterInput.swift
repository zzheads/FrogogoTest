//
//  UsersMainUsersMainRouterInput.swift
//  Test
//
//  Created by Alexey Papin on 14/10/2019.
//  Copyright © 2019 FroGoGo. All rights reserved.
//

import UIKit

protocol UsersMainRouterInput {
    func create(output: UserDetailsModuleOutput, from viewController: UIViewController)
    func edit(user: User, output: UserDetailsModuleOutput, from viewController: UIViewController)
}
