//
//  DataBaseManager.swift
//  Traces
//
//  Created by Ruslan Kozlov on 13.03.2024.
//

import Foundation
import FirebaseDatabase

final class DataBaseManager {

    static let shared = DataBaseManager()

    private let database = Database.database().reference()

}

// MARK: - Account Management
extension DataBaseManager {

    public func userExists(with email: String, completion: @escaping ((Bool) -> (Void))) {
        
        let safeEmail = email.replacingOccurrences(of: ".", with: ",")
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            if let userDict = snapshot.value as? [String: String], let _ = userDict["name"] {
                completion(true)
                print("пользователь есть, передаем true")
            } else {
                print("пользователя нет, передаем false")
                completion(false)
            }
        })
    }

    public func InsertUser(with user: TracesUser) {
        database.child(user.safeEmail).setValue([
            "name": user.name,
        ])
    }

}

struct TracesUser {
    let name: String
    let email: String

    var safeEmail: String {
        let safeEmail = email.replacingOccurrences(of: ".", with: ",")
        return safeEmail
    }
//    let profilePicture: String
}
