//
//  Extensions.swift
//  Traces
//
//  Created by Ruslan Kozlov on 18.03.2024.

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
