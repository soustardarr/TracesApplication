//
//  RegistraitionViewModel.swift
//  Traces
//
//  Created by Ruslan Kozlov on 18.03.2024.
//

import Foundation
import FirebaseAuth

class RegistraitionViewModel {
    
    func didRegisteredUser(_ name: String?, _ email: String?,
                           _ password: String?, _ secondPassword: String?,
                           completion: @escaping (_ boolResult: Bool, _ message: String?) -> ()) {
        guard let name = name,
              let login = email,
              let password = password,
              let secondPassword = secondPassword,
              !login.isEmpty,
              !password.isEmpty,
              !secondPassword.isEmpty,
              !name.isEmpty,
              password == secondPassword,
              password.count >= 6,
              name.count >= 3
        else {
            completion(false, "проверьте правильность введенной информации")
            return
        }
        DataBaseManager.shared.userExists(with: login) { exists in
            guard !exists else {
                completion(false, "пользователь с таким email уже сущевствует")
                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: login, password: password) { dataResult, error in
                guard dataResult != nil, error == nil else { return }
                DataBaseManager.shared.InsertUser(with: TracesUser(name: name, email: login))
                completion(true, nil)
            }

        }


    }
}
