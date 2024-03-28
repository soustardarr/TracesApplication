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


    // MARK: - Stored prop
    private var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .hybridFlyover
        return mapView
    }()

    private var buttonProfile: UIImageView = {
        let switchToProfile = UIImageView()
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [.black, .white])
        let profileImage = UIImage(systemName: "person.circle.fill", withConfiguration: colorConfig)
        switchToProfile.image = profileImage
        switchToProfile.isUserInteractionEnabled = true
        switchToProfile.translatesAutoresizingMaskIntoConstraints = false
        return switchToProfile
    }()

    private var buttonSettings: UIImageView = {
        let buttonSettings = UIImageView()
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [.black, .white])
        let settingsImage = UIImage(systemName: "gear.circle.fill", withConfiguration: colorConfig)
        buttonSettings.image = settingsImage
        buttonSettings.isUserInteractionEnabled = true
        buttonSettings.translatesAutoresizingMaskIntoConstraints = false
        return buttonSettings
    }()

    private var buttonWorld: UIImageView = {
        let buttonWorld = UIImageView()
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white])
        let worldImage = UIImage(systemName: "globe.asia.australia.fill", withConfiguration: colorConfig)
        buttonWorld.clipsToBounds = true
        buttonWorld.layer.cornerRadius = 35/2
        buttonWorld.image = worldImage
        buttonWorld.isUserInteractionEnabled = true
        buttonWorld.translatesAutoresizingMaskIntoConstraints = false
        return buttonWorld
    }()

    private var buttonLocation: UIImageView = {
        let buttonLocation = UIImageView()
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [.black, .white])
        let loctionImage = UIImage(systemName: "location.north.circle.fill", withConfiguration: colorConfig)
        buttonLocation.image = loctionImage
        buttonLocation.isUserInteractionEnabled = true
        buttonLocation.translatesAutoresizingMaskIntoConstraints = false
        return buttonLocation
    }()

    private var buttonFriends: UIImageView = {
        let buttonFriends = UIImageView()
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [.black, .white])
        let friendsImage = UIImage(systemName: "figure.2.circle.fill", withConfiguration: colorConfig)
        buttonFriends.image = friendsImage
        buttonFriends.isUserInteractionEnabled = true
        buttonFriends.translatesAutoresizingMaskIntoConstraints = false
        return buttonFriends
    }()

    private var buttonMessages: UIImageView = {
        let buttonMessages = UIImageView()
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [.black, .white])
        let messagesImage = UIImage(systemName: "message.circle.fill", withConfiguration: colorConfig)
        buttonMessages.image = messagesImage
        buttonMessages.translatesAutoresizingMaskIntoConstraints = false
        return buttonMessages
    }()

    private var grayViewBottom: UIView = {
        let grayView = UIView()
        grayView.backgroundColor = .black
        grayView.clipsToBounds = true
        grayView.layer.cornerRadius = 35
        grayView.translatesAutoresizingMaskIntoConstraints = false
        return grayView
    }()

    private var grayViewTop: UIView = {
        let grayView = UIView()
        grayView.backgroundColor = .black
        grayView.clipsToBounds = true
        grayView.layer.cornerRadius = 20
        grayView.translatesAutoresizingMaskIntoConstraints = false
        return grayView
    }()

    private var userForMap: UIImageView = {
        let userForMap = UIImageView()
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white, .systemGreen])
        let profileImage = UIImage(systemName: "figure.walk.circle.fill", withConfiguration: colorConfig)
        userForMap.image = profileImage
        userForMap.isUserInteractionEnabled = true
        userForMap.translatesAutoresizingMaskIntoConstraints = false
        userForMap.widthAnchor.constraint(equalToConstant: 40).isActive = true
        userForMap.heightAnchor.constraint(equalToConstant: 40).isActive = true
        userForMap.backgroundColor = .white
        userForMap.layer.borderWidth = 1
        userForMap.layer.borderColor = UIColor.black.cgColor
        userForMap.clipsToBounds = true
        userForMap.layer.cornerRadius = 20
        return userForMap
    }()



    private var viewModel: MainViewModel?

    private var userRegion: MKCoordinateRegion?

    // MARK: - Switching to other screen methods



    private func addGesture() {
        let gestureProfile = UITapGestureRecognizer(target: self, action: #selector(didTapProfileButton))
        buttonProfile.addGestureRecognizer(gestureProfile)
        let gestureFriends = UITapGestureRecognizer(target: self, action: #selector(didTapFriendsButton))
        buttonFriends.addGestureRecognizer(gestureFriends)

        let gestureLocation = UITapGestureRecognizer(target: self, action: #selector(didTapLocationButton))
        buttonLocation.addGestureRecognizer(gestureLocation)
    }

    @objc private func didTapLocationButton() {
        viewModel?.realTimeRegion()
        mapView.setRegion(userRegion ?? MKCoordinateRegion(), animated: true)
        mapView.setUserTrackingMode(.follow, animated: true)
    }

    @objc private func didTapProfileButton() {
        let profileVC = ProfileViewController()
        self.present(profileVC, animated: true)
    }

    @objc private func didTapFriendsButton() {
        let vc = FriendsViewController()
        let navVC = UINavigationController(rootViewController: vc)
        self.present(navVC, animated: true)
    }


    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        setUpLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
    }


    // MARK: - other methods


    private func setupSettings() {
        viewModel = MainViewModel()
        viewModel?.delegate = self
        mapView.delegate = self
        setupDataBindings()
        addGesture()
    }

    private func setupDataBindings() {
        viewModel?.getUserRegion = { [ weak self ] result in
            self?.userRegion = result
        }
        StorageManager.shared.downloadAvatarDataProfile()
        StorageManager.shared.getAvatarData = { result in
            guard let data = result else { return }
            DispatchQueue.main.async {
                self.userForMap.image = UIImage(data: data)
            }
        }

    }

    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = AuthorizationViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false)
        }
    }


    private func setUpLayout() {
        view.addSubview(mapView)
        view.addSubview(grayViewBottom)
        view.addSubview(grayViewTop)
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
            buttonProfile.widthAnchor.constraint(equalToConstant: 35),
            buttonProfile.heightAnchor.constraint(equalToConstant: 35),

            buttonSettings.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            buttonSettings.topAnchor.constraint(equalTo: buttonProfile.bottomAnchor, constant: 15),
            buttonSettings.widthAnchor.constraint(equalToConstant: 35),
            buttonSettings.heightAnchor.constraint(equalToConstant: 35),

            buttonWorld.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            buttonWorld.topAnchor.constraint(equalTo: buttonSettings.bottomAnchor, constant: 15),
            buttonWorld.widthAnchor.constraint(equalToConstant: 35),
            buttonWorld.heightAnchor.constraint(equalToConstant: 35),

            buttonLocation.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonLocation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonLocation.heightAnchor.constraint(equalToConstant: 60),
            buttonLocation.widthAnchor.constraint(equalToConstant: 60),


            buttonMessages.leadingAnchor.constraint(equalTo: buttonLocation.trailingAnchor, constant: 20),
            buttonMessages.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonMessages.heightAnchor.constraint(equalToConstant: 60),
            buttonMessages.widthAnchor.constraint(equalToConstant: 60),

            buttonFriends.trailingAnchor.constraint(equalTo: buttonLocation.leadingAnchor, constant: -20),
            buttonFriends.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonFriends.heightAnchor.constraint(equalToConstant: 60),
            buttonFriends.widthAnchor.constraint(equalToConstant: 60),

            grayViewBottom.widthAnchor.constraint(equalToConstant: 230),
            grayViewBottom.heightAnchor.constraint(equalToConstant: 70),
            grayViewBottom.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            grayViewBottom.centerYAnchor.constraint(equalTo: buttonLocation.centerYAnchor),

            grayViewTop.centerXAnchor.constraint(equalTo: buttonSettings.centerXAnchor),
            grayViewTop.centerYAnchor.constraint(equalTo: buttonSettings.centerYAnchor),
            grayViewTop.widthAnchor.constraint(equalToConstant: 40),
            grayViewTop.heightAnchor.constraint(equalToConstant: 145)
        ])
    }
}

// MARK: - Delegates

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
        annotationView.addSubview(userForMap)
        return annotationView
    }
}

