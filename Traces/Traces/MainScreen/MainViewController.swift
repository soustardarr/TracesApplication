//
//  ViewController.swift
//  Traces
//
//  Created by Ruslan Kozlov on 04.03.2024.
//

import UIKit
import MapKit
import FirebaseAuth


class MainViewController: UIViewController {

    var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .hybridFlyover
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        return mapView
    }()
    var buttonProfile: UIButton = {
        let buttonProfile = UIButton()
        buttonProfile.setImage(.profileIcon, for: .normal)
        buttonProfile.addTarget(nil, action: #selector(switchingToProfile), for: .touchUpInside)
        buttonProfile.translatesAutoresizingMaskIntoConstraints = false
        return buttonProfile
    }()

    var buttonSettings: UIButton = {
        let buttonSettings = UIButton()
        buttonSettings.setImage(.settingsIcon, for: .normal)
        buttonSettings.translatesAutoresizingMaskIntoConstraints = false
        return buttonSettings
    }()

    var buttonWorld: UIButton = {
        let buttonWorld = UIButton()
        buttonWorld.setImage(.worldIcon, for: .normal)
        buttonWorld.translatesAutoresizingMaskIntoConstraints = false
        return buttonWorld
    }()

    var buttonLocation: UIButton = {
        let buttonLocation = UIButton()
        buttonLocation.setImage(.locationIcon, for: .normal)
        buttonLocation.translatesAutoresizingMaskIntoConstraints = false
        return buttonLocation
    }()

    var buttonFriends: UIButton = {
        let buttonFriends = UIButton()
        buttonFriends.setImage(.friendsIcon, for: .normal)
        buttonFriends.addTarget(nil, action: #selector(switchingToFriendsScreen), for: .touchUpInside)
        buttonFriends.translatesAutoresizingMaskIntoConstraints = false
        return buttonFriends
    }()

    var buttonMessages: UIButton = {
        let buttonMessages = UIButton()
        buttonMessages.setImage(.messagesIcon, for: .normal)
        buttonMessages.translatesAutoresizingMaskIntoConstraints = false
        return buttonMessages
    }()

    private var viewModel: MainViewModel?

    @objc func switchingToProfile() {
        self.present(ProfileViewController(), animated: true)
    }

    @objc func switchingToFriendsScreen() {
        self.present(FriendsViewController(), animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        viewModel?.delegate = self
        mapView.delegate = self
        setUpLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }

    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = AuthorizationViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false)
        }
    }


    func setUpLayout() {
        view.addSubview(mapView)
        view.addSubview(buttonProfile)
        view.addSubview(buttonSettings)
        view.addSubview(buttonWorld)
        view.addSubview(buttonLocation)
        view.addSubview(buttonFriends)
        view.addSubview(buttonMessages)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            buttonProfile.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            buttonProfile.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),

            buttonSettings.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            buttonSettings.topAnchor.constraint(equalTo: buttonProfile.bottomAnchor, constant: 15),

            buttonWorld.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            buttonWorld.topAnchor.constraint(equalTo: buttonSettings.bottomAnchor, constant: 15),

            buttonLocation.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonLocation.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            buttonMessages.leadingAnchor.constraint(equalTo: buttonLocation.trailingAnchor, constant: 20),
            buttonMessages.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            buttonFriends.trailingAnchor.constraint(equalTo: buttonLocation.leadingAnchor, constant: -20),
            buttonFriends.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25)
        ])
    }
}

extension MainViewController: MainViewModelDelegate, MKMapViewDelegate {
    func didUpdateRegion(_ region: MKCoordinateRegion) {
        mapView.setRegion(region, animated: true)
    }

    func didFailWithError(_ error: Error) {
        print(error)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKUserLocation else {
            return nil
        }
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "UserLocation")
        annotationView.image = .iconLocation
        return annotationView
    }
}

