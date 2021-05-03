//
//  MyPoint.swift
//  MapDemoApp
//
//  Created by JungpyoHong on 4/27/21.
//

import MapKit

class MyPoint: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var locationName: String?
    var subtitle: String?
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        // called designated init
        super.init()
    }
}
