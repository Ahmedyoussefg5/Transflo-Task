//
//  LocationManger.swift
//  Transflo Task
//
//  Created by Youssef on 17/04/2023.
//

import Foundation
import CoreLocation

class LocationManger: NSObject, CLLocationManagerDelegate {
    
    private let locationManger = CLLocationManager()
    
    var isLocationEnabled: Bool {
        return locationManger.location != nil
    }
    
    var userLocation: CLLocation?
    
    var userLongitude: Double {
        return userLocation?.coordinate.longitude ?? locationManger.location?.coordinate.longitude ?? 0.0
    }
    
    var userLatitude: Double {
        return userLocation?.coordinate.latitude ?? locationManger.location?.coordinate.latitude ?? 0.0
    }
    
    override init() {
        super.init()
        locationManger.delegate = self
    }
    
    func checkAuthorizationStatus() {
        let authorizationStatus = locationManger.authorizationStatus
        
        switch authorizationStatus {
        case .notDetermined:
            config()
        case .restricted:
            config()
        case .denied:
            config()
        case .authorizedAlways:
            config()
        case .authorizedWhenInUse:
            config()
        @unknown default:
            config()
        }
    }
    
    private func config() {
        locationManger.requestAlwaysAuthorization()
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        userLocation = location
    }
}
