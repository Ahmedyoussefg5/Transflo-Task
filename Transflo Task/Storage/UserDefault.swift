//
//  UserDefault.swift
//  Transflo Task
//
//  Created by Youssef on 17/04/2023.
//


import Foundation
import Combine

@propertyWrapper
struct UserDefault<Value: Codable> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard
    private let publisher = PassthroughSubject<Value, Never>()
    
    var wrappedValue: Value {
        get {
            guard let savedData = container.object(forKey: key) as? Data, let loadedData = savedData.decode(to: Value.self)
            else { return defaultValue }
            return loadedData
        } set {
             
            // Check whether we're dealing with an optional and remove the object if the new value is nil.
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else if let encoded = newValue.toData() {
                container.set(encoded, forKey: key)
            }
            publisher.send(newValue)
        }
    }

    var projectedValue: AnyPublisher<Value, Never> {
        return publisher.eraseToAnyPublisher()
    }
}

extension UserDefault where Value: ExpressibleByNilLiteral {
    
    /// Creates a new User Defaults property wrapper for the given key.
    /// - Parameters:
    ///   - key: The key to use with the user defaults store.
    init(key: String, _ container: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil, container: container)
    }
}

/// Allows to match for optionals with generics that are defined as non-optional.
public protocol AnyOptional {
    /// Returns `true` if `nil`, otherwise `false`.
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}

extension Encodable {
    func toData() -> Data? {
        let encoder = JSONEncoder()
        let encoded = try? encoder.encode(self)
        return encoded
    }
}

extension Data {
    func decode<T: Decodable>(to model: T.Type) -> T? {
        let decoder = JSONDecoder()
        let decoded = try? decoder.decode(model.self, from: self)
        return decoded
    }
}
