//
//  UsersMainUsersMainViewController.swift
//  Test
//
//  Created by Alexey Papin on 14/10/2019.
//  Copyright © 2019 FroGoGo. All rights reserved.
//

import UIKit

class UsersMainViewController: UIViewController {
    var output: UsersMainViewOutput!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(UserCell.nib, forCellReuseIdentifier: UserCell.reuseIdentifier)
        self.output.viewIsReady()
    }
}

// MARK: - UsersMainViewInput
extension UsersMainViewController: UsersMainViewInput {
    func setupInitialState(title: String?, rightButton: UIBarButtonItem?, dataSource: UITableViewDataSource & UITableViewDelegate) {
        self.navigationItem.title = title
        self.navigationItem.rightBarButtonItem = rightButton
        self.tableView.dataSource = dataSource
        self.tableView.delegate = dataSource
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - ViewControllerable
extension UsersMainViewController: ViewControllerable {
    static func storyBoardName() -> String {
        return "UsersMain"
    }
}
