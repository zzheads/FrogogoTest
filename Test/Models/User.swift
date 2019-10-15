//
//  User.swift
//  Test
//
//  Created by Алексей Папин on 14.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import Alamofire

class User: Codable {
    var id          : Int
    var first_name  : String
    var last_name   : String
    var email       : String
    var avatar_url  : String
    var created_at  : String
    var updated_at  : String
    var url         : String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case first_name
        case last_name
        case email
        case avatar_url
        case created_at
        case updated_at
        case url
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.first_name = try container.decode(String.self, forKey: .first_name)
        self.last_name = try container.decode(String.self, forKey: .last_name)
        self.email = try container.decode(String.self, forKey: .email)
        if let avatar_url = try? container.decode(String.self, forKey: .avatar_url) {
            self.avatar_url = avatar_url
        } else {
            self.avatar_url = ""
        }
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
        self.url = try container.decode(String.self, forKey: .url)
    }
    
    public var avatarUrl: URL? {
        return URL(string: self.avatar_url)
    }
}

extension User {
    public struct DataModel: Codable {
        var first_name  : String
        var last_name   : String
        var email       : String
        var avatar_url  : String
    }
    
    var dataModel: DataModel {
        return DataModel(first_name: self.first_name, last_name: self.last_name, email: self.email, avatar_url: self.avatar_url)
    }
    
    static var getAll: Resource<User> {
        return Resource<User>(endpoint: "users.json", method: .get)
    }
    
    static func create(model: DataModel) -> Resource<User> {
        return Resource<User>(endpoint: "users.json", method: .post, parameters: model.toJSON, encoding: JSONEncoding.default)
    }
    
    static func edit(id: Int, model: DataModel) -> Resource<User> {
        return Resource<User>(endpoint: "users/\(id).json", method: .patch, parameters: model.toJSON, encoding: JSONEncoding.default)
    }
}
