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

    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "поиск по никнейму..."
        searchBar.backgroundColor = .black
        searchBar.searchTextField.textColor = .white
        searchBar.tintColor = .white
        return searchBar
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
        tableView.isHidden = true
        return tableView
    }()

    var noFriendsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 30)
        label.text = "друзей нет"
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var friendsViewModel: FriendsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        friendsTableView.isHidden = false
        setupUI()
    }

    private func setupSettings() {
        searchBar.delegate = self
        navigationController?.navigationBar.topItem?.titleView = searchBar
        let rightBarButton = UIBarButtonItem(title: "отмена",
                                             style: .done,
                                             target: self,
                                             action: #selector(didCancelTapped))
        rightBarButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButton
        friendsViewModel = FriendsViewModel()
        friendsTableView.delegate = self
        friendsTableView.dataSource = friendsViewModel
        friendsTableView.register(FriendsViewCell.self, forCellReuseIdentifier: FriendsViewCell.reuseIdentifier)

    }

    @objc func didCancelTapped() {
        dismiss(animated: true)
    }

    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(imageMinus)
        view.addSubview(friendsLabel)
        view.addSubview(inviteButton)
        view.addSubview(friendsTableView)
        view.addSubview(noFriendsLabel)
        NSLayoutConstraint.activate([

            imageMinus.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageMinus.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),

            friendsLabel.topAnchor.constraint(equalTo: imageMinus.bottomAnchor, constant: 25),
            friendsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            inviteButton.topAnchor.constraint(equalTo: imageMinus.bottomAnchor, constant: 25),
            inviteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inviteButton.widthAnchor.constraint(equalToConstant: 150),
            inviteButton.heightAnchor.constraint(equalToConstant: 40),

            friendsTableView.topAnchor.constraint(equalTo: inviteButton.bottomAnchor, constant: 10),
            friendsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            friendsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            friendsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])

    }

}

extension FriendsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UserViewController()
        vc.title = "друг"
        self.present(vc, animated: true)
    }

}


extension FriendsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

    }
}

