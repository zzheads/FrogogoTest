//
//  UserDetailsModuleOutput.swift
//  Test
//
//  Created by Алексей Папин on 15.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import Foundation

protocol UserDetailsModuleOutput {
    func create(user: User.DataModel)
    func edit(user: User.DataModel, id: Int)
}
