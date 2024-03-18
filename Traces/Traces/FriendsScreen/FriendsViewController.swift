//
//  FriendsViewController.swift
//  Traces
//
//  Created by Ruslan Kozlov on 14.03.2024.
//

import UIKit

class FriendsViewController: UIViewController {

    var imageMinus: UIImageView = {
        let imageMinus = UIImageView(image: .minus)
        imageMinus.translatesAutoresizingMaskIntoConstraints = false
        return imageMinus
    }()

    var searchTextField: UITextField = {
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray
        ]
        let attributedPlaceholder = NSAttributedString(string: "поиск по никнейму...", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.clipsToBounds = true
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 10
        return textField
    }()

    var inviteButton: UIButton = {
        let button = UIButton()
        button.setTitle("позвать друзей", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var friendsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.text = "друзья"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    var friendsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        return tableView
    }()

    private var friendsViewModel: FriendsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        setupUI()
    }

    private func setupSettings() {
        friendsViewModel = FriendsViewModel()
        friendsTableView.delegate = self
        friendsTableView.dataSource = friendsViewModel
        friendsTableView.register(FriendsViewCell.self, forCellReuseIdentifier: FriendsViewCell.reuseIdentifier)

    }

    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(imageMinus)
        view.addSubview(friendsLabel)
        view.addSubview(inviteButton)
        view.addSubview(searchTextField)
        view.addSubview(friendsTableView)
        NSLayoutConstraint.activate([

            imageMinus.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageMinus.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),

            friendsLabel.topAnchor.constraint(equalTo: imageMinus.bottomAnchor, constant: 25),
            friendsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            inviteButton.topAnchor.constraint(equalTo: imageMinus.bottomAnchor, constant: 25),
            inviteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inviteButton.widthAnchor.constraint(equalToConstant: 150),
            inviteButton.heightAnchor.constraint(equalToConstant: 40),

            searchTextField.topAnchor.constraint(equalTo: friendsLabel.bottomAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            searchTextField.heightAnchor.constraint(equalToConstant: 45),

            friendsTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            friendsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            friendsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            friendsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])

    }

}

extension FriendsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

}


