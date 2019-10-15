//
//  UserDetailsUserDetailsPresenter.swift
//  Test
//
//  Created by Alex on 15/10/2019.
//  Copyright © 2019 FroGoGo. All rights reserved.
//

import UIKit
import PromiseKit

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
        switch self.mode {
        case .create:
            self.getUserModel()
                .done { [weak self] model in self?.output.create(user: model) }
                .catch { [weak self] error in self?.view.viewController.show(error: error) }
            
        case .edit(let user):
            self.getUserModel()
                .done { [weak self] model in self?.output.edit(user: model, id: user.id) }
                .catch { [weak self] error in self?.view.viewController.show(error: error) }
        }
        self.view.viewController.navigationController?.popViewController(animated: true)
    }
    
    private func isValidEmail(emailStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    private func getUserModel() -> Promise<User.DataModel> {
        return Promise<User.DataModel> { [weak self] resolver in
            guard let firstName = self?.view.firstName, !firstName.isEmpty else {
                resolver.reject(AppError.badData(message: "First Name is must field"))
                return
            }
            guard let lastName = self?.view.lastName, !lastName.isEmpty else {
                resolver.reject(AppError.badData(message: "Last Name is must field"))
                return
            }
            guard let email = self?.view.email, self?.isValidEmail(emailStr: email) ?? false else {
                resolver.reject(AppError.badData(message: "Incorrect email format: \(self?.view.email ?? "")"))
                return
            }
            let avatarUrl = self?.view.avatarUrl ?? ""
            resolver.fulfill(User.DataModel(first_name: firstName, last_name: lastName, email: email, avatar_url: avatarUrl))
        }
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

