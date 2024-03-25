//
//  MainViewModel.swift
//  Traces
//
//  Created by Ruslan Kozlov on 06.03.2024.
//

import Foundation
import MapKit

protocol MainViewModelDelegate: AnyObject {
    func didUpdateRegion(_ region: MKCoordinateRegion)
//    func locationAuthorizationDenied()
//    func locationAuthorizationNotDetermined()
    func didFailWithError(_ error: Error)

}

class MainViewModel: NSObject {

    // MARK: - Stored prop

    var locationManager: CLLocationManager?
    weak var delegate: MainViewModelDelegate?
    var regionUser: MKCoordinateRegion? {
        didSet {
            getUserRegion?(regionUser)
        }
    }

    var getUserRegion: ((MKCoordinateRegion?) -> ())?

    func realTimeRegion() {
        guard let location = locationManager?.location else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        regionUser = region
    }

    // MARK: - Methods
    override init() {
        super.init()
        setupSettings()
    }

    private func setupSettings() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestLocation()
    }

    private func checkLocationAuthorization() {
        guard let locationManager = locationManager,
              let location = locationManager.location else { return }
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            self.delegate?.didUpdateRegion(region)
        case .denied:
            print("")
        case .notDetermined, .restricted:
            print("")
        default:
            print("")

        }

    }

}

// MARK: - Delegates

extension MainViewModel: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let newLocation = locations.last else { return }
//        regionUser = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegate?.didFailWithError(error)
    }

}
