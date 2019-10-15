//
//  UserDetailsUserDetailsViewController.swift
//  Test
//
//  Created by Alex on 15/10/2019.
//  Copyright © 2019 FroGoGo. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    var output: UserDetailsViewOutput!
    
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var avatarUrlTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.viewIsReady()
    }
}

// MARK: - UserDetailsViewInput
extension UserDetailsViewController: UserDetailsViewInput {
    func setupInitialState(title: String?, leftButton: UIBarButtonItem?, rightButton: UIBarButtonItem?, model: User.DataModel?) {
        self.navigationItem.title = title
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
        self.firstNameTextField.text = model?.first_name
        self.lastNameTextField.text = model?.last_name
        self.emailTextField.text = model?.email
        self.avatarUrlTextField.text = model?.avatar_url
    }
}

// MARK: - ViewControllerable
extension UserDetailsViewController: ViewControllerable {
    static func storyBoardName() -> String {
        return "UserDetails"
    }
}
