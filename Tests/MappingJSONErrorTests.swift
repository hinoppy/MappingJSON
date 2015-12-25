//
//  MappingJSONErrorTests.swift
//  MappingJSON
//
//  Created by Shinya Hino on 2015/12/22.
//  Copyright (c) 2015 Shinya Hino. All rights reserved.
//

import XCTest
@testable import MappingJSON

class MappingJSONErrorTests: XCTestCase {
    enum SomeEnum: Int{
        case One = 1
        case Two = 2
        case Three = 3
    }
    func testValueForKeyNotFound() {
        let raw = [
            "someValue": 2
        ]
        let json = MappingJSON(raw: raw)
        do {
            let _: Int = try json.value("anotherValue")
        } catch MappingJSON.Error.ValueForKeyNotFound(let key) {
            XCTAssertEqual(key, "anotherValue")
        } catch {
            XCTFail()
        }
    }
    func testTypeMismatch() {
        let raw = [
            "string": "1.0"
        ]
        let json = MappingJSON(raw: raw)
        do {
            let _: Int = try json.value("string")
        } catch MappingJSON.Error.TypeMismatch(let key, let value, let actualType) {
            XCTAssert(key == "string")
            XCTAssert(value as? String == "1.0")
            XCTAssert(actualType == value.dynamicType)
        } catch {
            XCTFail()
        }
    }
    func testUnwrapNil() {
        let raw = [
            "int": 4
        ]
        do {
            let json = MappingJSON(raw: raw)
            let _: SomeEnum = try json.value("int", transform: {(raw: Int) in SomeEnum(rawValue: raw)})
            XCTFail("must throw MappingJSON.Error.")
        } catch MappingJSON.Error.UnwrapNil {
        } catch _ {
            XCTFail()
        }
    }
}
