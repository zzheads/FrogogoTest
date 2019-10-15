//
//  WebService.swift
//  Test
//
//  Created by Алексей Папин on 14.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import Alamofire
import PromiseKit

protocol WebServiceProtocol {
    func fetch<T: Codable>(resource: Resource<T>) -> Promise<T>
    func fetchArray<T: Codable>(resource: Resource<T>) -> Promise<[T]> 
}

final class WebService: WebServiceProtocol {
    static let shared = WebService()
    
    private init() {
    }
    
    func fetch<T: Codable>(resource: Resource<T>) -> Promise<T> {
        return Promise<T>() { seal in
            resource.request.responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let json = value as? JSON else {
                        seal.reject(AppError.serialization(message: "value: \(value) is not json"))
                        return
                    }
                    guard let object = T(fromJSON: json) else {
                        seal.reject(AppError.serialization(message: "can't parse \(T.self) from json: \(json)"))
                        return
                    }
                    seal.fulfill(object)
                    
                case .failure(let error):
                    seal.reject(AppError.api(message: error.localizedDescription))
                }
            }
        }
    }
    
    func fetchArray<T: Codable>(resource: Resource<T>) -> Promise<[T]> {
        return Promise<[T]>() { seal in
            resource.request.responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let json = value as? [JSON] else {
                        seal.reject(AppError.serialization(message: "value: \(value) is not json array"))
                        return
                    }
                    guard let objects = [T](fromJSONArray: json) else {
                        seal.reject(AppError.serialization(message: "can't parse \([T].self) from json array: \(json)"))
                        return
                    }
                    seal.fulfill(objects)
                    
                case .failure(let error):
                    seal.reject(AppError.api(message: error.localizedDescription))
                }
            }
        }
    }
}
