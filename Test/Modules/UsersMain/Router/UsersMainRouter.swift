//
//  UsersMainUsersMainRouter.swift
//  Test
//
//  Created by Alexey Papin on 14/10/2019.
//  Copyright © 2019 FroGoGo. All rights reserved.
//

import UIKit

class UsersMainRouter: UsersMainRouterInput {
    func create(output: UserDetailsModuleOutput, from viewController: UIViewController) {
        UserDetailsModule.create(mode: .create, output: output).present(from: viewController)
    }
    
    func edit(user: User, output: UserDetailsModuleOutput, from viewController: UIViewController) {
        UserDetailsModule.create(mode: .edit(user), output: output).present(from: viewController)
    }
}
