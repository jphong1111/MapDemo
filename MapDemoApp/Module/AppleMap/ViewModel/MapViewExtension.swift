//
//  MapViewExtension.swift
//  MapDemoApp
//
//  Created by JungpyoHong on 4/24/21.
//

import MapKit

extension MKMapView {
    
    func centerTo(location: CLLocation, withRadius radius: CLLocationDistance) {
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        setRegion(region, animated: true)
    }
}
