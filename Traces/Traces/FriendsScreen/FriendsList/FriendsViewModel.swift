//
//  FriendsViewModel.swift
//  Traces
//
//  Created by Ruslan Kozlov on 18.03.2024.
//

import Foundation
import UIKit
import Combine

class FriendsViewModel {


    @Published var results: [[String: String]]?

    @Published var users = [[String: String]]()
    private var hasFetched = false

    func searchUsers(text: String) {
        if hasFetched {
            filterUsers(text)
        } else {
            DataBaseManager.shared.getAllUsers { [ weak self ] result in
                switch result {
                case .success(let users):
                    self?.hasFetched = true
                    self?.users = users
                    self?.filterUsers(text)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func filterUsers(_ text: String) {
        guard hasFetched else {
            return
        }

        let resultUsers: [[String: String]] = self.users.filter {
            guard let name = $0["name"]?.lowercased() else {
                return false
            }
            return name.hasPrefix(text.lowercased())
        }
        self.results = resultUsers
    }


}


