//
//  AppError.swift
//  Test
//
//  Created by Алексей Папин on 14.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import Foundation

enum AppError: Error {
    case api(message: String?)
    case serialization(message: String?)
}
