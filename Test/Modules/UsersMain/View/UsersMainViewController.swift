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
    @IBOutlet weak var searchViewContainer: UIView!
    @IBOutlet weak var searchViewHeightConstraint: NSLayoutConstraint!
    
    private var searchView: SearchView?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(UserCell.nib, forCellReuseIdentifier: UserCell.reuseIdentifier)
        if let searchView = SearchView.instanceFromNib(searchViewHeightConstraint: self.searchViewHeightConstraint) {
            self.searchViewContainer.addSubview(searchView)
            searchView.leftAnchor.constraint(equalTo: self.searchViewContainer.leftAnchor).isActive = true
            searchView.rightAnchor.constraint(equalTo: self.searchViewContainer.rightAnchor).isActive = true
            searchView.topAnchor.constraint(equalTo: self.searchViewContainer.topAnchor).isActive = true
            searchView.bottomAnchor.constraint(equalTo: self.searchViewContainer.bottomAnchor).isActive = true
            self.searchView = searchView
            self.searchView?.stateHandler = { [weak self] searchViewActive in
                self?.tableView.isHidden = searchViewActive
            }
            self.searchView?.maxHeight = self.tableView.bounds.height - 100
        }
        self.output.viewIsReady()
    }
}

// MARK: - UsersMainViewInput
extension UsersMainViewController: UsersMainViewInput {
    func setupInitialState(title: String?, rightButton: UIBarButtonItem?, dataSource: UITableViewDataSource & UITableViewDelegate, searchDataSource: SearchViewDataSource) {
        self.navigationItem.title = title
        self.navigationItem.rightBarButtonItem = rightButton
        self.tableView.dataSource = dataSource
        self.tableView.delegate = dataSource
        self.searchView?.dataSource = searchDataSource
        self.searchView?.reloadData()
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
