//
//  Keychain+StorageProtocol.swift
//  PersistentDataDemo
//
//  Created by Jorge Benavides on 23/03/23.
//

import Foundation

extension Keychain {

    func toData(_ value: Any) throws -> Data? {
        guard let data = value as? Data else {
            return try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        }
        return data
    }

    func valueFrom(_ data: Data) -> Any {
        guard let object = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
        else { return data }
        return object
    }


    // TODO: 2 Make Keychain implement the StorageProtocol
}

