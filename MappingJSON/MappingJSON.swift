//
//  MappingJSON.swift
//  MappingJSON
//
//  Created by Shinya Hino on 12/24/15.
//  Copyright © 2015 Shinya Hino. All rights reserved.
//

import Foundation

public class MappingJSON {
    enum Error: ErrorType {
        case ValueForKeyNotFound(key: String)
        case TypeMismatch(key: String, value: AnyObject, actualType: AnyObject.Type)
        case UnwrapNil
    }
    
    
    private var raw: [String: AnyObject]
    
    
    public init(raw: [String: AnyObject]) {
        self.raw = raw
    }
    public init(raw: [String: AnyObject], keyPath: [String]) throws {
        self.raw = raw
        if keyPath.isEmpty {
            return
        }
        for key in keyPath {
            self.raw = try self.value(key)
        }
    }

    
    public func value<T>(key: String) throws -> T {
        // get and unwrap value for key
        guard let rawValue = self.raw[key] else {
            throw Error.ValueForKeyNotFound(key: key)
        }
        if rawValue is NSNull {
            throw Error.ValueForKeyNotFound(key: key)
        }
        // cast value to T
        guard let value = rawValue as? T else {
            throw Error.TypeMismatch(key: key, value: rawValue, actualType: rawValue.dynamicType)
        }
        return value
    }
    public func optionalValue<T>(key: String) throws -> T? {
        do {
            let value: T = try self.value(key)
            return value
        } catch Error.ValueForKeyNotFound(_) {
            return nil
        }
    }
    
    
    public func value<T: Object where T.ObjectType == T>(key: String) throws -> T {
        guard let rawValue = self.raw[key] else {
            throw Error.ValueForKeyNotFound(key: key)
        }
        if rawValue is NSNull {
            throw Error.ValueForKeyNotFound(key: key)
        }
        guard let value = rawValue as? [String: AnyObject] else {
            throw Error.TypeMismatch(key: key, value: rawValue, actualType: rawValue.dynamicType)
        }
        return try MappingJSON(raw: value).map(T)
    }
    public func value<T: Object where T.ObjectType == T>(key: String) throws -> [T] {
        guard let rawValue = self.raw[key] else {
            throw Error.ValueForKeyNotFound(key: key)
        }
        if rawValue is NSNull {
            throw Error.ValueForKeyNotFound(key: key)
        }
        guard let values = rawValue as? [[String: AnyObject]] else {
            throw Error.TypeMismatch(key: key, value: rawValue, actualType: rawValue.dynamicType)
        }
        return try values.map { (value) -> T in
            try MappingJSON(raw: value).map(T)
        }
    }
    public func optionalValue<T: Object where T.ObjectType == T>(key: String) throws -> T? {
        do {
            let value: T = try self.value(key)
            return value
        } catch Error.ValueForKeyNotFound(_) {
            return nil
        }
    }
    public func optionalValue<T: Object where T.ObjectType == T>(key: String) throws -> [T]? {
        do {
            let values: [[String: AnyObject]] = try self.value(key)
            return try values.map { (value) -> T in
                try MappingJSON(raw: value).map(T)
            }
        } catch Error.ValueForKeyNotFound(_) {
            return nil
        }
    }
    public func map<T: Object where T.ObjectType == T>(type: T.Type) throws -> T {
        return try T.map(self)
    }
    
    
    
    public func value<T, U>(key: String, transform: (U) -> T?) throws -> T {
        let rawValue: U = try self.value(key)
        guard let value = transform(rawValue) else {
            throw Error.UnwrapNil
        }
        return value
    }
    public func optionalValue<T, U>(key: String, transform: (U) -> T?) throws -> T? {
        do {
            let value = try self.value(key, transform: transform)
            return value
        } catch Error.ValueForKeyNotFound(_) {
            return nil
        } catch Error.UnwrapNil {
            return nil
        }
    }
}