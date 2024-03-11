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

    var locationManager: CLLocationManager?
    weak var delegate: MainViewModelDelegate?

    override init() {
        super.init()
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
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 20000, longitudinalMeters: 20000)
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

extension MainViewModel: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegate?.didFailWithError(error)
    }

}
