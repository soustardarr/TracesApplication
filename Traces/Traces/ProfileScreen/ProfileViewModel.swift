//
//  ProfileViewModel.swift
//  Traces
//
//  Created by Ruslan Kozlov on 18.03.2024.
//

import Foundation
import FirebaseAuth

class ProfileViewModel {

    func setProfileData(completion: @escaping (Data) -> Void) {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else { return }
        let safeEmail = DataBaseManager.safeEmail(emailAddress: email)
        let fileName = safeEmail + "_profile_picture.png"

        let path = "images/" + fileName

        StorageManager.shared.getDownloadUrl(for: path) { result in
            switch result {
            case .success(let url):
                URLSession.shared.dataTask(with: url) { data, _, error in
                    guard let data = data, error == nil else { return }
                    completion(data)
                }.resume()
            case .failure(let error):
                print(error)
            }

        }
    }

}

