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

    private var friendButton: UIButton = {
        let button = UIButton()
        button.setTitle("подписаться", for: .normal)
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(nil, action: #selector(didTappedAddButton), for: .touchUpInside)
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
        tableView.isHidden = true
        tableView.separatorStyle = .none
        return tableView
    }()

    private var label: UILabel = {
        var label = UILabel()
        label.text = "когда то здесь будут его друзья"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var peopleProfileViewModel: PeopleProfileViewModel?

    init(avatarImage: UIImage, user: TracesUser) {
        super.init(nibName: nil, bundle: nil)
        self.avatarImageView.image = avatarImage
        self.nameLabel.text = user.name
        self.friendsUserLabel.text = "друзья \(user.name):"
        peopleProfileViewModel = PeopleProfileViewModel(currentUser: user)
        setupStatusFriendButton()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        setupDataBindings()
        setUpView()
        addGesture()
    }

    @objc private func didTappedAddButton() {
        peopleProfileViewModel?.changeFriendStatus()
    }

    private func setupStatusFriendButton() {
        let status = peopleProfileViewModel?.checkFriendStatus()
        switch status {
        case .selfSubscribed:
            friendButton.setTitle("отписаться", for: .normal)
            friendButton.backgroundColor = .systemRed
        case .heSubscribedForSelf:
            friendButton.setTitle("подписаться в ответ", for: .normal)
            friendButton.backgroundColor = .systemBlue
        case .inFriends:
            friendButton.setTitle("удалить из друзей", for: .normal)
            friendButton.backgroundColor = .systemGray
        case .cleanStatus:
            friendButton.setTitle("подписаться", for: .normal)
            friendButton.backgroundColor = .systemGray
        case .none:
            friendButton.setTitle("none status", for: .normal)
            friendButton.backgroundColor = .red
        }
    }

    private func addGesture() {


    }

    private func setupSettings() {

    }

    private func setupDataBindings() {

    }

    private func setUpView() {
        view.backgroundColor = .darkGray

        view.addSubview(imageMinus)
        view.addSubview(buttonSettings)
        view.addSubview(nameLabel)
        view.addSubview(avatarImageView)
        view.addSubview(buttonMessage)
        view.addSubview(friendButton)
        view.addSubview(friendsUserLabel)
        view.addSubview(friendsTableView)
        view.addSubview(label)
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

            friendButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            friendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            friendButton.heightAnchor.constraint(equalToConstant: 35),
            friendButton.widthAnchor.constraint(equalToConstant: 120),

            friendsUserLabel.topAnchor.constraint(equalTo: friendButton.bottomAnchor, constant: 30),
            friendsUserLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            friendsTableView.topAnchor.constraint(equalTo: friendsUserLabel.bottomAnchor, constant: 10),
            friendsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            friendsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            friendsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),

        ])
    }
}

