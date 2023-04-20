import Foundation
import Logger

public struct StorageManager {

    private let storage: StorageProtocol
    private let logger: Logging

    public init(storage: StorageProtocol, logger: Logging = Logger()) {
        self.storage = storage
        self.logger = logger
    }

}

// TODO: 1 Make StorageManager implement the StorageManagerProtocol
