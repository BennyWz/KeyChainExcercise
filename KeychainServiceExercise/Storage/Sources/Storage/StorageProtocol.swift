import Foundation

public protocol StorageProtocol {
    /// Store any value for a specific key overriding previous value if exists
    func set<T>(_ value: T?, forKey key: StorageKey) throws
    /// Retrieves any value for a specific key or nil if none exists
    func get<T>(forKey key: StorageKey) throws -> T?
    /// Store any value for a specific key throwing duplicate error if previous value exists
    func add<T>(_ value: T?, forKey key: StorageKey) throws
    /// Removes (sets to nil) any value for a specific key
    func remove(forKey key: StorageKey) throws
}

public extension StorageProtocol {
    /// Store a Encodable value for a specific key overriding previous value if exists
    func store<T>(_ value: T?, forKey key: StorageKey, usingEncoder encoder: JSONEncoder = .init()) throws where T: Encodable {
        let data = try encoder.encode(value)
        try set(data, forKey: key)
    }
    
    /// Retrieves a Decodable value for a specific key or nil if none exists
    func retrieve<T>(forKey key: StorageKey, usingDecoder decoder: JSONDecoder = .init()) throws -> T? where T: Decodable {
        guard let data: Data = try get(forKey: key) else {
            return nil
        }
        return try decoder.decode(T.self, from: data) as T
    }
    
}
