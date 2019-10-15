//
//  UserDetailsUserDetailsPresenter.swift
//  Test
//
//  Created by Alex on 15/10/2019.
//  Copyright © 2019 FroGoGo. All rights reserved.
//

import UIKit

class UserDetailsPresenter {
    weak var view: UserDetailsViewInput!
    var interactor: UserDetailsInteractorInput!
    var router: UserDetailsRouterInput!
    var output: UserDetailsModuleOutput!
    let mode: UserDetailsModule.Mode
    
    var title: String {
        switch self.mode {
        case .create            : return "Create New User"
        case .edit(let user)    : return "Edit User with id: \(user.id)"
        }
    }
    
    var user: User? {
        switch self.mode {
        case .create            : return nil
        case .edit(let user)    : return user
        }
    }
        
    init(mode: UserDetailsModule.Mode) {
        self.mode = mode
    }
    
    @objc private func cancel() {
        self.view.viewController.navigationController?.popViewController(animated: true)
    }
    
    @objc private func save() {
        self.view.viewController.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UserDetailsModuleInput
extension UserDetailsPresenter: UserDetailsModuleInput {
    func present(from viewController: UIViewController) {
        self.view.present(from: viewController)
    }
}

// MARK: - UserDetailsViewOutput
extension UserDetailsPresenter: UserDetailsViewOutput {
    func viewIsReady() {
        let leftButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancel))
        let rightButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.save))
        self.view.setupInitialState(title: self.title, leftButton: leftButton, rightButton: rightButton, model: self.user?.dataModel)
    }
}

// MARK: - UserDetailsInteractorOutput
extension UserDetailsPresenter: UserDetailsInteractorOutput {
    
}

