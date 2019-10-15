//
//  UsersMainUsersMainInteractorOutput.swift
//  Test
//
//  Created by Alexey Papin on 14/10/2019.
//  Copyright © 2019 FroGoGo. All rights reserved.
//

import Foundation

protocol UsersMainInteractorOutput: class {
    func set(users: [User])
    func created(user: User)
    func edited(user: User)
    func set(error: Error)
}
