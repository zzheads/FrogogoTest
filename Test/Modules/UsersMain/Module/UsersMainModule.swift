//
//  UsersMainUsersMainConfigurator.swift
//  Test
//
//  Created by Alexey Papin on 14/10/2019.
//  Copyright © 2019 FroGoGo. All rights reserved.
//

import UIKit

class UsersMainModule {
    class func create() -> UsersMainModuleInput {
        let viewController = UsersMainViewController.create()
        
        let router = UsersMainRouter()
        let interactor = UsersMainInteractor(client: ApiClient.shared)
        
        let presenter = UsersMainPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        viewController.output = presenter
        interactor.output = presenter
        
        return presenter
    }
}
