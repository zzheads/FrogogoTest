//
//  UsersMainUsersMainInteractor.swift
//  Test
//
//  Created by Alexey Papin on 14/10/2019.
//  Copyright © 2019 FroGoGo. All rights reserved.
//

class UsersMainInteractor: UsersMainInteractorInput {
    weak var output: UsersMainInteractorOutput!
    let client: ApiClientProtocol
    
    init(client: ApiClientProtocol) {
        self.client = client
    }

    func getUsers() {
        self.client.getUsers()
            .done { [weak self] users in self?.output.set(users: users) }
            .catch { [weak self] error in self?.output.set(error: error) }
    }
    
    func create(user: User.DataModel) {
        self.client.create(user: user)
            .done { [weak self] user in self?.output.created(user: user) }
            .catch { [weak self] error in self?.output.set(error: error) }
    }
    
    func edit(user: User.DataModel, id: Int) {
        self.client.edit(id: id, user: user)
            .done { [weak self] user in self?.output.edited(user: user) }
            .catch { [weak self] error in self?.output.set(error: error) }
    }
}
