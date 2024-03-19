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

    static func safeEmail(emailAddress: String) -> String {
        let safeEmail = emailAddress.replacingOccurrences(of: ".", with: ",")
        return safeEmail
    }

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

    public func insertUser(with user: TracesUser, completion: @escaping (Bool) -> ()) {
        database.child(user.safeEmail).setValue([
            "name": user.name,
        ]) { error, _ in
            guard error == nil else {
                completion(false)
                return
            }

            self.database.child("users").observeSingleEvent(of: .value) { snapshot in
                if var usersCollection = snapshot.value as? [[String: String]] {

                } else {
                    let newCollection: [[String: String]] = [
                        [
                            "name": user.name,
                            "email": user.safeEmail
                        ]
                    ]
                    // to do 
                }
            }

            completion(true)
        }
    }

}

