//
//  User+CoreDataProperties.swift
//  Traces
//
//  Created by Ruslan Kozlov on 28.03.2024.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var profilePicture: Data?
    @NSManaged public var name: String?
    @NSManaged public var age: Int64
    @NSManaged public var safeEmail: String?
    @NSManaged public var email: String?
    @NSManaged public var profilePictureFileName: String?
    @NSManaged public var friends: Set<User>?
    @NSManaged public var followers: Set<User>?
    @NSManaged public var subscriptions: Set<User>?

}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: User)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: User)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

// MARK: Generated accessors for followers
extension User {

    @objc(addFollowersObject:)
    @NSManaged public func addToFollowers(_ value: User)

    @objc(removeFollowersObject:)
    @NSManaged public func removeFromFollowers(_ value: User)

    @objc(addFollowers:)
    @NSManaged public func addToFollowers(_ values: NSSet)

    @objc(removeFollowers:)
    @NSManaged public func removeFromFollowers(_ values: NSSet)

}

// MARK: Generated accessors for subscriptions
extension User {

    @objc(addSubscriptionsObject:)
    @NSManaged public func addToSubscriptions(_ value: User)

    @objc(removeSubscriptionsObject:)
    @NSManaged public func removeFromSubscriptions(_ value: User)

    @objc(addSubscriptions:)
    @NSManaged public func addToSubscriptions(_ values: NSSet)

    @objc(removeSubscriptions:)
    @NSManaged public func removeFromSubscriptions(_ values: NSSet)

}

extension User : Identifiable {

}
