//
//  Coordinate.swift
//  MapDemoApp
//
//  Created by JungpyoHong on 4/27/21.
//

import Foundation
import CoreLocation

class Coordinate: Codable {
    let latitude: String
    let longitude: String
    
    init(location: CLLocation) {
        self.latitude = String(location.coordinate.latitude)
        self.longitude = String(location.coordinate.longitude)
    }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.latitude = String(coordinate.latitude)
        self.longitude =  String(coordinate.longitude)
    }
    
    init(lat: String, lon: String) {
        self.latitude = lat
        self.longitude = lon
    }
}
