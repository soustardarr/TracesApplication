//
//  FriendsViewCell.swift
//  Traces
//
//  Created by Ruslan Kozlov on 18.03.2024.
//

import UIKit

class FriendsViewCell: UITableViewCell {

    var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView(image: .profile)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()

    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "привет"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func config(_ friend: Friend) {
        avatarImageView.image = friend.avatar
        nameLabel.text = friend.name
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .black
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),

            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 30)
        ])

    }


}
