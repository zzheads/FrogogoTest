//
//  UsersMainUsersMainViewInput.swift
//  Test
//
//  Created by Alexey Papin on 14/10/2019.
//  Copyright © 2019 FroGoGo. All rights reserved.
//

import UIKit

protocol UsersMainViewInput: class, Presentable {
    func setupInitialState(title: String?, rightButton: UIBarButtonItem?, dataSource: UITableViewDataSource & UITableViewDelegate) 
    func reloadData()
}
