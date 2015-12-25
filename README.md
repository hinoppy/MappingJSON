# MappingJSON
[![Build Status](https://travis-ci.org/hinoppy/MappingJSON.svg?branch=master)](https://travis-ci.org/hinoppy/MappingJSON)

MappingJSON is a framework written in Swift to make it easy to map JSON to your object.

## Requirements
- Swift 2.1 / Xcode 7.2
- OS X 10.10 or later
- iOS 8.0 or later
- tvOS 9.1 or later
- watchOS 2.1 or later

## Usage
Objects just need to implement ```Object``` protocol for mapping.
```swift
import MappingJSON

struct User: Object {
    var id: Int
    var name: String
    var email: String
    var age: Int?
    
    // Object protocol
    static func map(json: MappingJSON) throws -> User {
        return try User(
            id: json.value("id"),
            name: json.value("name"),
            email: json.value("email"),
            age: json.optionalValue("age")
        )
    }
}
```

Convert JSON to your object as below.

```swift
let rawJSON = [String: AnyObject] = [
    "id": 1,
    "name": "William",
    "email": "example@example.com",
    "age": 22
]

// initialize MappingJSON with raw JSON object
let json = MappingJSON(raw: rawJSON)

// pass your object type to 'map' function
let user = try? json.map(User)

print(user.email) // shows 'example@example.com' to you console!
```

## Transforms
You can transform raw values from JSON to what ever objects you like.  
To transform, simply add a closure to second argument of ```value``` or ```optionalValue``` function.

```swift
struct User: Object {
    var id: Int
    var name: String
    var email: String
    var age: Int?
    var birthday: NSDate?
    
    // Object protocol
    static func map(json: MappingJSON) throws -> User {
        return try User(
            id: json.value("id"),
            name: json.value("name"),
            email: json.value("email"),
            age: json.optionalValue("age"),
            birthday: json.optionalValue("birthday", transform: dateTransform)
        )
    }
}
static let dateTransform = {(timestamp: NSTimeInterval) in
    NSDate(timeIntervalSince1970: timestamp)
}
```

## License
MappingJSON is released under the [MIT license](https://github.com/hinoppy/MappingJSON/blob/master/LICENSE).

