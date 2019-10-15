//
//  UserDetailsUserDetailsViewInput.swift
//  Test
//
//  Created by Alex on 15/10/2019.
//  Copyright © 2019 FroGoGo. All rights reserved.
//

import UIKit

protocol UserDetailsViewInput: class, Presentable {
    func setupInitialState(title: String?, leftButton: UIBarButtonItem?, rightButton: UIBarButtonItem?, model: User.DataModel?)
}
