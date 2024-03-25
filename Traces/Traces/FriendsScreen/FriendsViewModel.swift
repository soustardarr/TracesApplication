//
//  FriendsViewModel.swift
//  Traces
//
//  Created by Ruslan Kozlov on 18.03.2024.
//

import Foundation
import UIKit

class FriendsViewModel: NSObject {

    private var users = [[String: String]]()
    var results = [[String: String]]()
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


extension FriendsViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsViewCell.reuseIdentifier, for: indexPath) as? FriendsViewCell
        let friend = Friend(name: results[indexPath.row]["name"] ?? "", avatar: .profile)
        cell?.config(friend)
        return cell ?? UITableViewCell()
    }
    

}
