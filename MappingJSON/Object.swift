//
//  Object.swift
//  MappingJSON
//
//  Created by Shinya Hino on 12/24/15.
//  Copyright © 2015 Shinya Hino. All rights reserved.
//

import Foundation

public enum ObjectError: ErrorType {
    case MissingKeyPath(String)
    case TypeMismatch(expected: String, actual: String, key: String?)
}

public protocol Object {
    typealias ObjectType = Self
    static func map(json: MappingJSON) throws -> ObjectType
}

