//
//  TracesUser.swift
//  Traces
//
//  Created by Ruslan Kozlov on 18.03.2024.
//

import Foundation

struct TracesUser {
    let name: String
    let email: String

    var safeEmail: String {
        let safeEmail = email.replacingOccurrences(of: ".", with: ",")
        return safeEmail
    }
    var profilePictureFileName: String {
        return "\(safeEmail)_profile_picture.png"
    }
}
