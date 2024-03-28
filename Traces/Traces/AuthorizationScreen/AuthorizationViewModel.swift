//
//  AuthorizationViewModel.swift
//  Traces
//
//  Created by Ruslan Kozlov on 18.03.2024.
//

import Foundation
import FirebaseAuth

class AuthorizationViewModel {

    func didLoginAccount(_ email: String?, _ password: String?, completion: @escaping (Bool) -> ()) {
        guard let login = email,
              let password = password,
              !login.isEmpty,
              !password.isEmpty,
              password.count >= 6
        else {
            completion(false)
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: login, password: password) { authResult, error in
            guard let authRes = authResult, error == nil else {
                completion(false)
                return
            }
            print(authRes)
            UserDefaults.standard.set(login, forKey: "email")
            completion(true)
        }

    }

    

}
