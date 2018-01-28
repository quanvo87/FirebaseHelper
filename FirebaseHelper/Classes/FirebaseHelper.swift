import FirebaseDatabase

public typealias DataCallback = (Result<DataSnapshot, Error>) -> Void
public typealias ErrorCallback = (Error?) -> Void

public enum FirebaseHelperError: Error {
    case invalidPath

    var localizedDescription: String {
        switch self {
        case .invalidPath:
            return "Attempted to read the database at an invalid location."
        }
    }
}

public enum Result<T, Error> {
    case success(T)
    case failure(Error)
}

public struct FirebaseHelper {
    private let ref: DatabaseReference

    public init(_ ref: DatabaseReference) {
        self.ref = ref
    }

    public func delete(_ first: String, _ rest: String..., completion: @escaping ErrorCallback) {
        delete(first, rest, completion: completion)
    }

    public func delete(_ first: String, _ rest: [String], completion: @escaping ErrorCallback) {
        do {
            try makeReference(first, rest).removeValue { (error, _) in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }

    public func get(_ first: String, _ rest: String..., completion: @escaping DataCallback) {
        get(first, rest, completion: completion)
    }

    public func get(_ first: String, _ rest: [String], completion: @escaping DataCallback) {
        do {
            try makeReference(first, rest).observeSingleEvent(of: .value) { (data) in
                completion(.success(data))
            }
        } catch {
            completion(.failure(error))
        }
    }

    public func increment(_ amount: Int, at first: String, _ rest: String..., completion: @escaping ErrorCallback) {
        increment(amount, at: first, rest, completion: completion)
    }

    public func increment(_ amount: Int, at first: String, _ rest: [String], completion: @escaping ErrorCallback) {
        do {
            try makeReference(first, rest).runTransactionBlock({ (currentData) -> TransactionResult in
                if let value = currentData.value {
                    var newValue = value as? Int ?? 0
                    newValue += amount
                    currentData.value = newValue
                    return .success(withValue: currentData)
                }
                return .success(withValue: currentData)
            }) { (error, _, _) in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }

    public func makeReference(_ first: String, _ rest: String...) throws -> DatabaseReference {
        return try makeReference(first, rest)
    }

    public func makeReference(_ first: String, _ rest: [String]) throws -> DatabaseReference {
        do {
            return try ref.child(String.makePath(first, rest))
        } catch {
            throw error
        }
    }

    public func set(_ value: Any, at first: String, _ rest: String..., completion: @escaping ErrorCallback) {
        set(value, at: first, rest, completion: completion)
    }

    public func set(_ value: Any, at first: String, _ rest: [String], completion: @escaping ErrorCallback) {
        do {
            try makeReference(first, rest).setValue(value) { (error, _) in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }
}

private extension String {
    static func makePath(_ first: String, _ rest: String...) throws -> String {
        return try makePath(first, rest)
    }

    static func makePath(_ first: String, _ rest: [String]) throws -> String {
        return try ([first] + rest).map { child -> String in
            let trimmed = child.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            guard trimmed != "" && !trimmed.contains("//") else {
                throw FirebaseHelperError.invalidPath
            }
            return trimmed
            }.joined(separator: "/")
    }
}
