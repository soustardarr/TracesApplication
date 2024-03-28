//
//  PeopleProfileViewModel.swift
//  Traces
//
//  Created by Ruslan Kozlov on 26.03.2024.
//

import Foundation

enum FriendStatus {
    case selfSubscribed
    case heSubscribedForSelf
    case inFriends
    case cleanStatus
}

class PeopleProfileViewModel {

    var currentUser: TracesUser

    init(currentUser: TracesUser) {
        self.currentUser = currentUser
    }

    func changeFriendStatus() {
        let status = checkFriendStatus()
        switch status {
        case .selfSubscribed:
            DataBaseManager.shared.deleteFollow()
        case .heSubscribedForSelf:
            DataBaseManager.shared.addFollow(for: currentUser)
        case .inFriends:
            DataBaseManager.shared.deleteFollow()
        case .cleanStatus:
            DataBaseManager.shared.addFollow(for: currentUser)
        }
    }

    func checkFriendStatus() -> FriendStatus {
        var selfEmail = UserDefaults.standard.value(forKey: "email")
        selfEmail = DataBaseManager.safeEmail(emailAddress: selfEmail as! String)

        if let currentUserFriends = currentUser.friends, // в друзьях ли мы
           currentUserFriends.contains(where: {$0.safeEmail == selfEmail as! String}) {
            return .inFriends
        } else if let currentUserFollowers = currentUser.followers, // подписан ли я на него
                  currentUserFollowers.contains(where: {$0.safeEmail == selfEmail as! String}) {
            return .selfSubscribed
        } else if let currentUserSubscriptions = currentUser.subscriptions, // подписан ли он на меня
                  currentUserSubscriptions.contains(where: { $0.safeEmail == selfEmail as! String }){
            return .heSubscribedForSelf
        } else {
            return .cleanStatus
        }
    }


}
