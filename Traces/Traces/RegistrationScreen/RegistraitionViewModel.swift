//
//  RegistraitionViewModel.swift
//  Traces
//
//  Created by Ruslan Kozlov on 18.03.2024.
//

import Foundation
import FirebaseAuth
import UIKit

class RegistraitionViewModel {
    
    func didRegisteredUser(_ name: String?, _ email: String?, _ password: String?, _ secondPassword: String?, _ avatar: UIImage?,
                           completion: @escaping (_ boolResult: Bool, _ message: String?) -> ()) {
        guard let name = name, let login = email,
              let password = password, let secondPassword = secondPassword,
              let image = avatar,
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
                let user = TracesUser(name: name, email: login)
                DataBaseManager.shared.insertUser(with: user) { succes in
                    if succes {
                        guard let data = image.pngData() else { return }
                        let fileName = user.profilePictureFileName
                        StorageManager.shared.uploadAvatarImage(with: data, fileName: fileName) { result in
                            switch result {
                            case .success(let downloadUrl):
                                UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                print("ссылка на скачивание: \(downloadUrl)")
                            case .failure(let error):
                                print("ошибка хранилища: \(error)")
                            }
                        }

                    }
                }
                completion(true, nil)
            }

        }


    }
}
