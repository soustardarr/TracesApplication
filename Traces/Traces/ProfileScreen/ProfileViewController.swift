//
//  ProfileViewController.swift
//  Traces
//
//  Created by Ruslan Kozlov on 06.03.2024.
//

import UIKit

class ProfileViewController: UIViewController {

    var imageMinus: UIImageView = {
        var imageMinus = UIImageView(image: .minus)
        imageMinus.translatesAutoresizingMaskIntoConstraints = false
        return imageMinus
    }()

    var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView(image: .profile)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()

    var nameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.text = "Some Name"
        nameLabel.font = UIFont.systemFont(ofSize: 30)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()

    var ageLabel: UILabel = {
        var ageLabel = UILabel()
        ageLabel.text = "12.03.2001"
        ageLabel.font = UIFont.systemFont(ofSize: 15)
        ageLabel.textColor = .lightGray
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        return ageLabel
    }()

    var numberOfFriendsLabel: UILabel = {
        var numberOfFriendsLabel = UILabel()
        numberOfFriendsLabel.text = "213"
        numberOfFriendsLabel.font = UIFont.systemFont(ofSize: 25)
        numberOfFriendsLabel.textColor = .lightGray
        numberOfFriendsLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberOfFriendsLabel
    }()

    var friendsButton: UIButton = {
        var friendsButton = UIButton()
        friendsButton.setTitle("друзья", for: .normal)
        friendsButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        friendsButton.tintColor = .white
        friendsButton.translatesAutoresizingMaskIntoConstraints = false
        return friendsButton
    }()

//    var namberOfStories: UILabel = {
//        var numberOfFriendsLabel = UILabel()
//        numberOfFriendsLabel.text = "23"
//        numberOfFriendsLabel.font = UIFont.systemFont(ofSize: 25)
//        numberOfFriendsLabel.textColor = .lightGray
//        numberOfFriendsLabel.translatesAutoresizingMaskIntoConstraints = false
//        return numberOfFriendsLabel
//    }()

    var settingsButton: UIButton = {
        var storiesButton = UIButton()
        storiesButton.setTitle("настройки", for: .normal)
        storiesButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        storiesButton.tintColor = .white
        storiesButton.translatesAutoresizingMaskIntoConstraints = false
        return storiesButton
    }()

    var exitButton: UIButton = {
        var exitButton = UIButton()
        exitButton.setTitle("выйти", for: .normal)
        exitButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        exitButton.tintColor = .white
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        return exitButton
    }()

    var invitationButton: UIButton = {
        var invitationButton = UIButton()
        invitationButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        invitationButton.backgroundColor = .white
        invitationButton.setTitle("Пригласить друзей", for: .normal)
        invitationButton.setTitleColor(.black, for: .normal)
        invitationButton.layer.cornerRadius = 20
        invitationButton.clipsToBounds = true
        invitationButton.translatesAutoresizingMaskIntoConstraints = false
        return invitationButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }

    private func setUpView() {

        view.backgroundColor = .black
        view.addSubview(imageMinus)
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(ageLabel)
        view.addSubview(friendsButton)
        view.addSubview(numberOfFriendsLabel)
        view.addSubview(settingsButton)
        view.addSubview(exitButton)
        view.addSubview(invitationButton)
        NSLayoutConstraint.activate([
            
            imageMinus.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageMinus.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),

            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: imageMinus.bottomAnchor, constant: 20),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.heightAnchor.constraint(equalToConstant: 150),

            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),

            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            ageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            friendsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            friendsButton.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 50),

            numberOfFriendsLabel.leadingAnchor.constraint(equalTo: friendsButton.trailingAnchor, constant: 20),
            numberOfFriendsLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 56),

            settingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            settingsButton.topAnchor.constraint(equalTo: friendsButton.bottomAnchor, constant: 15),

            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            exitButton.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 15),

            invitationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            invitationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            invitationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            invitationButton.heightAnchor.constraint(equalToConstant: 100)


        ])
    }
}
