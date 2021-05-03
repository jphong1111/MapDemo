//
//  CustomAnnotationView.swift
//  MapDemoApp
//
//  Created by JungpyoHong on 4/27/21.
//

import UIKit
import MapKit

class CustomAnnotationView: NSObject, MKAnnotation {
    let placeName: String?
    let placeLocationName: String?
    let descriptions: String?
    let coordinate: CLLocationCoordinate2D
    
init(placeName: String, placeLocationName: String, description: String, coordinate: CLLocationCoordinate2D) {
        self.placeName = placeName
        self.placeLocationName = placeLocationName
        self.descriptions  = description
        self.coordinate = coordinate
        super.init()
    }
}
