//
//  DataBaseManager.swift
//  Traces
//
//  Created by Ruslan Kozlov on 13.03.2024.
//

import Foundation
import FirebaseDatabase

enum DataBaseError: Error {
    case failedReceivingUsers
}

final class DataBaseManager {

    static let shared = DataBaseManager()

    private let database = Database.database().reference()

    static var selfUser: TracesUser?


    static func safeEmail(emailAddress: String) -> String {
        let safeEmail = emailAddress.replacingOccurrences(of: ".", with: ",")
        return safeEmail
    }

}

// MARK: - Account Management
extension DataBaseManager {

    public func getSelfProfileInfo(completionHandler: @escaping (Result<TracesUser, Never>) -> ()) {
        guard let email = UserDefaults.standard.string(forKey: "email") else { return }
        let safeEmail = DataBaseManager.safeEmail(emailAddress: email)
        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            if let userDict = snapshot.value as? [String: String], let userName = userDict["name"] {
                let user = TracesUser(name: userName, email: email)
                completionHandler(.success(user))
            }
        }
    }

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
            "friends": [TracesUser](),
            "followers": [TracesUser](),
            "subscriptions": [TracesUser](),
        ]) { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            self.database.child("users").observeSingleEvent(of: .value) { snapshot in
                if var usersCollection = snapshot.value as? [[String: String]] {
                    usersCollection.append([
                        "name": user.name,
                        "email": user.safeEmail
                    ])
                    self.database.child("users").setValue(usersCollection) { error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        completion(true)
                    }
                } else {
                    let newCollection: [[String: String]] = [
                        [
                            "name": user.name,
                            "email": user.safeEmail
                        ]
                    ]
                    self.database.child("users").setValue(newCollection) { error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        completion(true)
                    }
                }
            }
        }
    }


    func getAllUsers(completion: @escaping (Result<[[String: String]], Error>) -> ()) {
        database.child("users").observeSingleEvent(of: .value) { dataSnapshot  in
            guard let value = dataSnapshot.value as? [[String: String]] else {
                completion(.failure(DataBaseError.failedReceivingUsers))
                return
            }
            completion(.success(value))
        }
    }
}


// MARK: - User Subscription Status Manager

extension DataBaseManager {


    // currentUser - тот на кого подписываемся
    // selfUser - аккаунт с которого подписываемся
    func addFollow(for currentUser: TracesUser) {
//        var selfEmail = UserDefaults.standard.string(forKey: "email")
//        selfEmail = DataBaseManager.safeEmail(emailAddress: selfEmail!)
//
//        let currentUserDict = [
//            "name": currentUser.name,
//            "email": currentUser.email,
//            "safeEmail": currentUser.safeEmail,
//            "profilePictureFileName": currentUser.profilePictureFileName
//        ]
//        let dataCurrentUser = ["subscriptions": currentUserDict ]
//        database.child(selfEmail!).setValue(dataCurrentUser)
//
////        DataBaseManager.shared.getSelfProfileInfo { [ weak self ] result in
////            switch result {
//        //            case .success(let selfUser):
//        let selfUser = TracesUser(name: <#T##String#>, email: <#T##String#>)
//        let selfUserDict = [
//            "name": selfUser.name,
//            "email": selfUser.email,
//            "safeEmail": selfUser.safeEmail,
//            "profilePictureFileName": selfUser.profilePictureFileName
//        ]
//        let dataSelfUser = ["followers": selfUserDict ]
//        database.child(currentUser.safeEmail).setValue(dataSelfUser)
//

    }

    func deleteFollow() {

    }

}
