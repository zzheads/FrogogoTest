//
//  UsersMainUsersMainPresenter.swift
//  Test
//
//  Created by Alexey Papin on 14/10/2019.
//  Copyright © 2019 FroGoGo. All rights reserved.
//

import UIKit
import Nuke

class UsersMainPresenter: NSObject {
    weak var view: UsersMainViewInput!
    var interactor: UsersMainInteractorInput!
    var router: UsersMainRouterInput!
    var users: [User] = []
}

// MARK: - UsersMainModuleInput
extension UsersMainPresenter: UsersMainModuleInput {
    func presentAsNavController() {
        self.view.presentAsNavController()
    }
}

// MARK: - UsersMainViewOutput
extension UsersMainPresenter: UsersMainViewOutput {
    @objc private func addPressed(_ sender: UIBarButtonItem) {
        self.router.create(output: self, from: self.view.viewController)
    }
    
    func viewIsReady() {
        let rightButton =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addPressed(_:)))
        self.view.setupInitialState(title: "Frogogo Users", rightButton: rightButton, dataSource: self)
        self.interactor.getUsers()
    }
}

// MARK: - UsersMainInteractorOutput
extension UsersMainPresenter: UsersMainInteractorOutput {
    func created(user: User) {
        self.users.append(user)
        self.view.reloadData()
    }
    
    func edited(user: User) {
        guard let index = self.users.firstIndex(where: { $0.id == user.id }) else { return }
        self.users[index] = user
        self.view.reloadData()
    }
    
    func set(users: [User]) {
        self.users = users
        self.view.reloadData()
    }
    
    func set(error: Error) {
        self.view.viewController.show(error: error)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension UsersMainPresenter: UITableViewDataSource & UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier, for: indexPath) as! UserCell
        cell.configure(with: self.users[indexPath.row])
        if let imageUrl = self.users[indexPath.row].avatarUrl {
            let options = ImageLoadingOptions(placeholder: UIImage(named: "placeholder"), transition: .fadeIn(duration: 0.33))
            Nuke.loadImage(with: imageUrl, options: options, into: cell.avatarImageView)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router.edit(user: self.users[indexPath.row], output: self, from: self.view.viewController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UserDetailsModuleOutput
extension UsersMainPresenter: UserDetailsModuleOutput {
    func create(user: User.DataModel) {
        self.interactor.create(user: user)
    }
    
    func edit(user: User.DataModel, id: Int) {
        self.interactor.edit(user: user, id: id)
    }
}
