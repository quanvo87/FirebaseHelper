# FirebaseHelper

<!--[![CI Status](http://img.shields.io/travis/quanvo87/FirebaseHelper.svg?style=flat)](https://travis-ci.org/quanvo87/FirebaseHelper)-->
[![Version](https://img.shields.io/cocoapods/v/FirebaseHelper.svg?style=flat)](http://cocoapods.org/pods/FirebaseHelper)
[![License](https://img.shields.io/cocoapods/l/FirebaseHelper.svg?style=flat)](http://cocoapods.org/pods/FirebaseHelper)
[![Platform](https://img.shields.io/cocoapods/p/FirebaseHelper.svg?style=flat)](http://cocoapods.org/pods/FirebaseHelper)

FirebaseHelper is a small wrapper over Firebase's realtime database, providing streamlined methods for get, set, delete, and increment values.

## Features
- [x] Setup Firebase Realtime Database Ref
- [x] Read values (get)
- [x] Write/Update values (set)
- [x] Remove values (delete)
- [x] Increment values (increment)

## Requirements

Swift 4

## Installation

FirebaseHelper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FirebaseHelper'
```

## Usage

Initialize an instance of `FirebaseHelper`:

```swift
import Firebase
import FirebaseHelper

let firebaseHelper = FirebaseHelper(FirebaseDatabase.Database.database().reference())
```

`FirebaseHelper(_ ref: DatabaseReference)` takes in a `DatabaseReference`. Generally you'd want this to be the root of your database.

For convenience, you can add something like this to your project:

```swift
extension FirebaseHelper {
    static let main: FirebaseHelper = {
        FirebaseHelper(FirebaseDatabase.Database.database().reference())
    }()
}
```

And now you can simply call `FirebaseHelper.main` to access this instance of `FirebaseHelper` from anywhere in your project.

### Common Database Operations

#### Get

Example:

```swift
FirebaseHelper.main.get("users", "john123", "favoriteFood") { result in
    switch result {
      case .failure(let error):
        // handle error
      case .success(let data):
        // get string from data
    }
}
```

API:

```swift
public func get(_ first: String, _ rest: String..., completion: @escaping (Result<DataSnapshot, Error>) -> Void)
```

`get()` takes in a variadic parameter of child nodes that will be built on the `DatabaseReference` you initialized your instance of `FirebaseHelper` on.

The callback returns a `Result`:

```swift
public enum Result<T, Error> {
    case success(T)
    case failure(Error)
}
```

In this case, `T` is `DataSnapshot`. An error case will either be because an invalid child was passed in or some other error in your database.

#### Set, Delete, Increment

`set()`, `delete()`, and `increment()` work similarly, but instead of returning a `Result`, they simply return an `Error` if one occurred, or `nil` otherwise.

Examples:

```swift
// The first parameter is an `Any` that gets set at the specified path.
FirebaseHelper.main.set("pizza", at: "users", "john123", "favoriteFood") { error in
    if let error = error {
      // handle error
  }
}

FirebaseHelper.main.delete("users", "john123", "favoriteFood") { error in
    if let error = error {
      // handle error
  }
}

FirebaseHelper.main.increment(by: 5, "users", "john123", "favoriteFoodEatenThisMonth") {
    if let error = error {
      // handle error
  }
}
```

APIs:

```swift
public func set(_ value: Any, at first: String, _ rest: String..., completion: @escaping (Error?) -> Void)

public func delete(_ first: String, _ rest: String..., completion: @escaping (Error?) -> Void)

public func increment(by amount: Int, at first: String, _ rest: String..., completion: @escaping (Error?) -> Void)
```

> Note: You should only `set()` accepted value types. See [Firebase docs](https://firebase.google.com/docs/database/ios/read-and-write#basic_write).

#### Safely Make A DatabaseReference

You will often need to call more complex `FirebaseDatabase` functions, such as building a query and calling `observe(_ eventType: with block:)` on it. `FirebaseHelper` can still help with that:

```swift
let ref = try? FirebaseHelper.main.makeReference("users", "john123", "eatingHistory")
let handle = ref?.queryOrdered(byChild: "timestamp").queryLimited(toLast: 50).observe(.value) { data in
    // handle data
}
```

API:

```swift
public func makeReference(_ first: String, _ rest: String...) throws -> DatabaseReference
```

`makeReference` will throw an error if passed an invalid child.

## Collaborators

- [Quan Vo](https://github.com/quanvo87)
- [Wilson Ding](https://github.com/dingwilson)

## License

FirebaseHelper is available under the MIT license. See the LICENSE file for more info.
