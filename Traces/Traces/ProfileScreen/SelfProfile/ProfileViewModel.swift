//
//  ProfileViewModel.swift
//  Traces
//
//  Created by Ruslan Kozlov on 18.03.2024.
//

import Foundation
import FirebaseAuth

class ProfileViewModel {

    @Published var user: TracesUser?

    func getUserInfo() {
        DataBaseManager.shared.getProfileInfo { result in
            switch result {
            case .success(let user):
                self.user = user
            }
        }

    }

}

