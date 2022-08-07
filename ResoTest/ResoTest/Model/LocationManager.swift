//
//  LocationManager.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 15.07.2022.
//

import Foundation
import CoreLocation

class LocationManger: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    static let shared = LocationManger()
    var currentLocation: CLLocation?
    
    private override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.distanceFilter = 10
        }
    }
    
    func determineMyCurrentLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        self.currentLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    func calculateDistance(latitude: Double, longtitude: Double) -> Double {
        let destination = CLLocation(latitude: latitude, longitude: longtitude)
        let distance = ((self.currentLocation?.distance(from: destination) ?? 0) / 1000)
        return distance
    }
    
    
}
