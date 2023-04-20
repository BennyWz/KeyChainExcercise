//
//  KeychainViewController.swift
//  PersistentDataDemo
//
//  Created by Jorge Benavides on 23/03/23.
//

import UIKit
import Storage

class KeychainViewController: FormViewController {

    var user: User?

    // TODO: 3. Create an initialize that receives an object managing the storage operations
     let storageManager: StorageManagerProtocol
    let keychain: KeychainProtocol

    init(keychain: KeychainProtocol = Keychain.standard) {
        self.keychain = keychain
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Keychain"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .trash, target: self, action: #selector(trashButtonPressed))
    }

    // TODO: 4.1 Use the instance `storageManager` to do 'storage' operations
    @objc func trashButtonPressed() {
        do {
            try keychain.delete(account: "kUserModel")
        } catch {
            print("Can not remove keys")
        }
    }

    // TODO: 4.2 Use the instance `storageManager` to do 'storage' operations
    override func writeData() {
        user = writeFormView.getData

        do {
            let data = try JSONEncoder().encode(user)
            try keychain.update(data, account: "kUserModel")
        } catch {
            print("Can not store:", error)
        }
    }

    // TODO: 4.3 Use the instance `storageManager` to do 'storage' operations
    override func readData() {
        do {
            guard let data = try keychain.read(account: "kUserModel") else {
                throw NSError(domain: Bundle.main.bundlePath, code: -1)
            }
            user = try JSONDecoder().decode(User.self, from: data)
        } catch {
            print("Can not retrieve:", error)
        }

        readFormView.setData(user)
    }

}
