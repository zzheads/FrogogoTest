//
//  ApiClient.swift
//  Test
//
//  Created by Алексей Папин on 14.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import PromiseKit

protocol ApiClientProtocol {
    func getUsers() -> Promise<[User]>
    func create(user: User.DataModel) -> Promise<User>
    func edit(id: Int, user: User.DataModel) -> Promise<User>
}

class ApiClient: ApiClientProtocol {
    static let shared = ApiClient(webService: WebService.shared)
    
    let service: WebServiceProtocol
    
    private init(webService: WebServiceProtocol) {
        self.service = webService
    }
    
    func getUsers() -> Promise<[User]> {
        return Promise<[User]> { resolver in
            self.service.fetchArray(resource: User.getAll)
                .done { resolver.fulfill($0) }
                .catch { resolver.reject($0) }
        }
    }
    
    func create(user: User.DataModel) -> Promise<User> {
        return Promise<User> { resolver in
            self.service.fetch(resource: User.create(model: user))
                .done { resolver.fulfill($0) }
                .catch { resolver.reject($0) }
        }
    }
    
    func edit(id: Int, user: User.DataModel) -> Promise<User> {
        return Promise<User> { resolver in
            self.service.fetch(resource: User.edit(id: id, model: user))
                .done { resolver.fulfill($0) }
                .catch { resolver.reject($0) }
        }
    }
}
