//
//  UserDetailsUserDetailsConfigurator.swift
//  Test
//
//  Created by Alex on 15/10/2019.
//  Copyright © 2019 FroGoGo. All rights reserved.
//

import UIKit

class UserDetailsModule {
    public enum Mode {
        case create
        case edit(User)
    }
    
    class func create(mode: Mode, output: UserDetailsModuleOutput) -> UserDetailsModuleInput {
        let controller = UserDetailsViewController.create()
        
        let router = UserDetailsRouter()
        let interactor = UserDetailsInteractor()
        let presenter = UserDetailsPresenter(mode: mode)
        presenter.view = controller
        presenter.router = router
        presenter.interactor = interactor
        presenter.output = output
        
        interactor.output = presenter
        controller.output = presenter
        
        return presenter
    }
}
