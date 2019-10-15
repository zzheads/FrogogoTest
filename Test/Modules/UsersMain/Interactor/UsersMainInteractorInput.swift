//
//  UsersMainUsersMainInteractorInput.swift
//  Test
//
//  Created by Alexey Papin on 14/10/2019.
//  Copyright © 2019 FroGoGo. All rights reserved.
//

import Foundation

protocol UsersMainInteractorInput {
    func getUsers()
    func create(user: User.DataModel) 
    func edit(user: User.DataModel, id: Int)
}
