//
//  PeopleProfileController.swift
//  Traces
//
//  Created by Ruslan Kozlov on 26.03.2024.
//

import UIKit

class PeopleProfileController: UIViewController {

    private var imageMinus: UIImageView = {
        var imageMinus = UIImageView(image: .minus)
        imageMinus.translatesAutoresizingMaskIntoConstraints = false
        return imageMinus
    }()

    private var buttonSettings: UIImageView = {
        let buttonSettings = UIImageView()
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [.gray])
        let settingsImage = UIImage(systemName: "gearshape.fill", withConfiguration: colorConfig)
        buttonSettings.image = settingsImage
        buttonSettings.isUserInteractionEnabled = true
        buttonSettings.translatesAutoresizingMaskIntoConstraints = false
        return buttonSettings
    }()

    private var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.image = .kitty
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 60
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()

    private var nameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.text = "Some Name"
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()

    private var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("добавить", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var buttonMessage: UIImageView = {
        let buttonMessage = UIImageView()
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [.gray])
        let messageImage = UIImage(systemName: "message.badge.circle.fill", withConfiguration: colorConfig)
        buttonMessage.image = messageImage
        buttonMessage.isUserInteractionEnabled = true
        buttonMessage.translatesAutoresizingMaskIntoConstraints = false
        return buttonMessage
    }()

    private var friendsUserLabel: UILabel = {
        var friendsUser = UILabel()
        friendsUser.text = "друзья Some Name:"
        friendsUser.font = UIFont.systemFont(ofSize: 22)
        friendsUser.textColor = .gray
        friendsUser.translatesAutoresizingMaskIntoConstraints = false
        return friendsUser
    }()

    private var friendsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .green
        tableView.separatorStyle = .none
        return tableView
    }()

    private func addGesture() {

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        setupDataBindings()
        setUpView()
        addGesture()
    }

    private func setupSettings() {

    }

    private func setupDataBindings() {

    }

    private func setUpView() {
        view.backgroundColor = .systemMint

        view.addSubview(imageMinus)
        view.addSubview(buttonSettings)
        view.addSubview(nameLabel)
        view.addSubview(avatarImageView)
        view.addSubview(buttonMessage)
        view.addSubview(addButton)
        view.addSubview(friendsUserLabel)
        view.addSubview(friendsTableView)
        NSLayoutConstraint.activate([
            imageMinus.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageMinus.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            
            buttonSettings.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonSettings.topAnchor.constraint(equalTo: imageMinus.bottomAnchor, constant: 10),
            buttonSettings.widthAnchor.constraint(equalToConstant: 35),
            buttonSettings.heightAnchor.constraint(equalToConstant: 35),

            nameLabel.topAnchor.constraint(equalTo: buttonSettings.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            avatarImageView.topAnchor.constraint(equalTo: buttonSettings.topAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.heightAnchor.constraint(equalToConstant: 150),

            buttonMessage.leadingAnchor.constraint(equalTo: buttonSettings.trailingAnchor, constant: 20),
            buttonMessage.topAnchor.constraint(equalTo: imageMinus.bottomAnchor, constant: 10),
            buttonMessage.widthAnchor.constraint(equalToConstant: 36),
            buttonMessage.heightAnchor.constraint(equalToConstant: 36),

            addButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.heightAnchor.constraint(equalToConstant: 35),
            addButton.widthAnchor.constraint(equalToConstant: 100),

            friendsUserLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 30),
            friendsUserLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            friendsTableView.topAnchor.constraint(equalTo: friendsUserLabel.bottomAnchor, constant: 10),
            friendsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            friendsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            friendsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
