//
//  FriendsViewModel.swift
//  Traces
//
//  Created by Ruslan Kozlov on 18.03.2024.
//

import Foundation
import UIKit

class FriendsViewModel: NSObject, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsViewCell.reuseIdentifier, for: indexPath) as? FriendsViewCell
        cell?.config(users[indexPath.row])
        return cell ?? UITableViewCell()
    }
    

    let users = [
        Friend(name: "ghbdtn", avatar: .profile),
        Friend(name: "ghbdtn", avatar: .profile),
        Friend(name: "ghbdtn", avatar: .profile),
        Friend(name: "ghbdtn", avatar: .profile),
        Friend(name: "ghbdtn", avatar: .profile),
        Friend(name: "ghbdtn", avatar: .profile),
        Friend(name: "ghbdtn", avatar: .profile),
        Friend(name: "ghbdtn", avatar: .profile),
    ]

}
