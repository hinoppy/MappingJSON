//
//  MappingJSONTests.swift
//  MappingJSONTests
//
//  Created by Shinya Hino on 2015/12/22.
//  Copyright (c) 2015 Shinya Hino. All rights reserved.
//

import XCTest
@testable import MappingJSON

class MappingJSONTests: XCTestCase {
    lazy var rawParent: [String: AnyObject] = {
        return [
            "int": 20,
            "string": "William",
            "float": 1.23,
            "timestamp": NSDate().timeIntervalSince1970,
            "bool": true,
            "array": [1, 2],
            "dictionary": ["key": "value"],
            "child": self.rawChildObject,
            "children": [self.rawChildObject, self.rawChildObject, self.rawChildObject],
            "enumInt": 1,
            "enumString": "Two",
            "optionalInt": 20,
            "optionalFloat": 1.23,
            "optionalTimestamp": NSDate().timeIntervalSince1970,
            "optionalBool": true,
            "optionalArray": [1, 2],
            "optionalDictionary": ["key": "value"],
            "optionalChild": self.rawChildObject,
            "optionalChildren": [self.rawChildObject, self.rawChildObject, self.rawChildObject],
            "optionalEnumInt": 1,
            "optionalEnumString": "Two",
            "optionalNestedObject": self.rawNestedParent,
            "null": NSNull()
        ]
    }()
    lazy var rawNestedParent: [String: AnyObject] = {
        return [
            "int": 18,
            "string": "Ivan",
            "float": 3.55,
            "timestamp": NSDate().timeIntervalSince1970,
            "bool": true,
            "array": [1, 2],
            "dictionary": ["key": "value"],
            "child": self.rawChildObject,
            "children": [self.rawChildObject, self.rawChildObject, self.rawChildObject],
            "enumInt": 1,
            "enumString": "Two",
            "optionalInt": 20,
            "optionalFloat": 1.23,
            "optionalTimestamp": NSDate().timeIntervalSince1970,
            "optionalBool": true,
            "optionalArray": [1, 2],
            "optionalDictionary": ["key": "value"],
            "optionalChild": self.rawChildObject,
            "optionalChildren": [self.rawChildObject, self.rawChildObject, self.rawChildObject],
            "optionalEnumInt": 1,
            "optionalEnumString": "Two",
            "optionalNestedObject": NSNull(),
            "null": NSNull()
        ]
    }()
    lazy var rawChildObject: [String: AnyObject] = {
        return [
            "someValue": 1,
            "anotherValue": "hoge",
            "child": self.rawGrandChildObject
        ]
    }()
    lazy var rawGrandChildObject: [String: AnyObject] = {
        return [
            "someValue": 10,
            "anotherValue": "foo"
        ]
    }()
    static let timeStampToDate: (timeStamp: NSTimeInterval) -> NSDate? =  {(timestamp) in
        NSDate(timeIntervalSince1970: timestamp)
    }
    
    enum EnumInt: Int {
        case One = 1
        case Two
        case Three
    }
    enum EnumString: String {
        case One = "One"
        case Two = "Two"
        case Three = "Three"
    }
    class Parent: Object {
        let int: Int
        let string: String
        let float: Float
        let date: NSDate
        let array: [Int]
        let bool: Bool
        let dictionary: [String: String]
        let child: Child
        let children: [Child]
        let enumInt: EnumInt
        let enumString: EnumString
        let optionalInt: Int?
        let optionalString: String?
        let optionalFloat: Float?
        let optionalDate: NSDate?
        let optionalArray: [Int]?
        let optionalBool: Bool?
        let optionalDictionary: [String: String]?
        let optionalChild: Child?
        let optionalChildren: [Child]?
        let optionalEnumInt: EnumInt?
        let optionalEnumString: EnumString?
        let optionalNestedObject: Parent?
        let nilInt: Int?
        let nilString: String?
        let nilFloat: Float?
        let nilDate: NSDate?
        let nilArray: [Int]?
        let nilBool: Bool?
        let nilDictionary: [String: String]?
        let nilChild: Child?
        let nilChildren: [Child]?
        let nilEnumInt: EnumInt?
        let nilEnumString: EnumString?
        init(
            int: Int,
            string: String,
            float: Float,
            date: NSDate,
            array: [Int],
            bool: Bool,
            dictionary: [String: String],
            child: Child,
            children: [Child],
            enumInt: EnumInt,
            enumString: EnumString,
            optionalInt: Int?,
            optionalString: String?,
            optionalFloat: Float?,
            optionalDate: NSDate?,
            optionalArray: [Int]?,
            optionalBool: Bool?,
            optionalDictionary: [String: String]?,
            optionalChild: Child?,
            optionalChildren: [Child]?,
            optionalEnumInt: EnumInt?,
            optionalEnumString: EnumString?,
            optionalNestedObject: Parent?,
            nilInt: Int?,
            nilString: String?,
            nilFloat: Float?,
            nilDate: NSDate?,
            nilArray: [Int]?,
            nilBool: Bool?,
            nilDictionary: [String: String]?,
            nilChild: Child?,
            nilChildren: [Child]?,
            nilEnumInt: EnumInt?,
            nilEnumString: EnumString?
            ) {
                self.int = int
                self.string = string
                self.float = float
                self.date = date
                self.array = array
                self.bool = bool
                self.dictionary = dictionary
                self.child = child
                self.children = children
                self.enumInt = enumInt
                self.enumString = enumString
                self.optionalInt = optionalInt
                self.optionalString = optionalString
                self.optionalFloat = optionalFloat
                self.optionalDate = optionalDate
                self.optionalArray = optionalArray
                self.optionalBool = optionalBool
                self.optionalDictionary = optionalDictionary
                self.optionalChild = optionalChild
                self.optionalChildren = optionalChildren
                self.optionalEnumInt = optionalEnumInt
                self.optionalEnumString = optionalEnumString
                self.optionalNestedObject = optionalNestedObject
                self.nilInt = nilInt
                self.nilString = nilString
                self.nilFloat = nilFloat
                self.nilDate = nilDate
                self.nilArray = nilArray
                self.nilBool = nilBool
                self.nilDictionary = nilDictionary
                self.nilChild = nilChild
                self.nilChildren = nilChildren
                self.nilEnumInt = nilEnumInt
                self.nilEnumString = nilEnumString
        }
        static func map(json: MappingJSON) throws -> Parent {
            return try Parent(
                int: json.value("int"),
                string: json.value("string"),
                float: json.value("float"),
                date: json.value("timestamp", transform: {(timestamp: NSTimeInterval) in NSDate(timeIntervalSince1970: timestamp)}),
                array: json.value("array"),
                bool: json.value("bool"),
                dictionary: json.value("dictionary"),
                child: json.value("child"),
                children: json.value("children"),
                enumInt: json.value("enumInt", transform: {(raw: Int) in EnumInt(rawValue: raw)}),
                enumString: json.value("enumString", transform: {(raw: String) in EnumString(rawValue: raw)}),
                optionalInt: json.optionalValue("optionalInt"),
                optionalString: json.optionalValue("optionalString"),
                optionalFloat: json.optionalValue("optionalFloat"),
                optionalDate: json.optionalValue("optionalTimestamp", transform: {(timestamp: NSTimeInterval) in NSDate(timeIntervalSince1970: timestamp)}),
                optionalArray: json.optionalValue("optionalArray"),
                optionalBool: json.optionalValue("optionalBool"),
                optionalDictionary: json.optionalValue("optionalDictionary"),
                optionalChild: json.optionalValue("optionalChild"),
                optionalChildren: json.optionalValue("optionalChildren"),
                optionalEnumInt: json.optionalValue("optionalEnumInt", transform: {(raw: Int) in EnumInt(rawValue: raw)}),
                optionalEnumString: json.optionalValue("optionalEnumString", transform: {(raw: String) in EnumString(rawValue: raw)}),
                optionalNestedObject: json.optionalValue("optionalNestedObject"),
                nilInt: json.optionalValue("null"),
                nilString: json.optionalValue("null"),
                nilFloat: json.optionalValue("null"),
                nilDate: json.optionalValue("null", transform: {(timestamp: NSTimeInterval) in NSDate(timeIntervalSince1970: timestamp)}),
                nilArray: json.optionalValue("null"),
                nilBool: json.optionalValue("null"),
                nilDictionary: json.optionalValue("null"),
                nilChild: json.optionalValue("null"),
                nilChildren: json.optionalValue("null"),
                nilEnumInt: json.optionalValue("null"),
                nilEnumString: json.optionalValue("null")
            )
        }
    }
    class Child: Object {
        let someValue: Int
        let anotherValue: String
        let child: GrandChild
        
        init(someValue: Int, anotherValue: String, child: GrandChild) {
            self.someValue = someValue
            self.anotherValue = anotherValue
            self.child = child
        }
        static func map(json: MappingJSON) throws -> Child {
            return try Child(
                someValue: json.value("someValue"),
                anotherValue: json.value("anotherValue"),
                child: json.value("child")
            )
        }
    }
    class GrandChild: Object {
        let someValue: Int
        let anotherValue: String
        init(someValue: Int, anotherValue: String) {
            self.someValue = someValue
            self.anotherValue = anotherValue
        }
        
        static func map(json: MappingJSON) throws -> GrandChild {
            return try GrandChild(
                someValue: json.value("someValue"),
                anotherValue: json.value("anotherValue")
            )
        }
    }
    
    func testMappingObject() {
        do {
            let raw = self.rawParent
            let json = MappingJSON(raw: raw)
            let object = try json.map(Parent)
            XCTAssert(object.int == 20)
            XCTAssert(object.string == "William")
            XCTAssert(object.float == 1.23 as Float)
            XCTAssert(object.bool == true)
            XCTAssert(object.array[1] == 2)
            XCTAssert(object.dictionary["key"] == "value")
            XCTAssert(object.child.someValue == 1)
            XCTAssert(object.children[0].anotherValue == "hoge")
            XCTAssert(object.enumInt == .One)
            XCTAssert(object.enumString == .Two)
            XCTAssert(object.optionalInt == 20)
            XCTAssert(object.optionalBool == true)
            XCTAssert(object.optionalArray?[1] == 2)
            XCTAssert(object.optionalDictionary?["key"] == "value")
            XCTAssert(object.optionalChild?.someValue == 1)
            XCTAssert(object.optionalChildren?[0].anotherValue == "hoge")
            XCTAssert(object.optionalNestedObject?.string == "Ivan")
            XCTAssert(object.optionalEnumInt == .One)
            XCTAssert(object.optionalEnumString == .Two)
            XCTAssert(object.nilInt == nil)
            XCTAssert(object.nilBool == nil)
            XCTAssert(object.nilArray?[1] == nil)
            XCTAssert(object.nilDictionary?["key"] == nil)
            XCTAssert(object.nilChild?.someValue == nil)
            XCTAssert(object.nilChildren == nil)
            XCTAssert(object.nilEnumInt == nil)
            XCTAssert(object.nilEnumString == nil)
            
        } catch MappingJSON.Error.UnwrapNil {
            XCTFail("Found nil while Unwrapping")
        } catch MappingJSON.Error.TypeMismatch(let key, _, let actualType) {
            XCTFail("value for '\(key)' should be type '\(actualType)'")
        } catch MappingJSON.Error.ValueForKeyNotFound(let key) {
            XCTFail("value for '\(key)' not found")
        } catch {
            XCTFail()
        }
    }
    func testCreatingJSONWithKeyPath() {
        do {
            let raw = self.rawParent
            let json = try MappingJSON(raw: raw, keyPath: ["child", "child"])
            let grandChild = try json.map(GrandChild)
            XCTAssert(grandChild.someValue == 10)
            XCTAssert(grandChild.anotherValue == "foo")
        } catch MappingJSON.Error.UnwrapNil {
            XCTFail("Found nil while Unwrapping")
        } catch MappingJSON.Error.TypeMismatch(let key, _, let actualType) {
            XCTFail("value for '\(key)' should be type '\(actualType)'")
        } catch MappingJSON.Error.ValueForKeyNotFound(let key) {
            XCTFail("value for '\(key)' not found")
        } catch {
            XCTFail()
        }
    }
}
