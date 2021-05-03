//
//  Location.swift
//  MapDemoApp
//
//  Created by JungpyoHong on 4/27/21.
//

import Foundation

struct Location: Codable {
    let coordinate: Coordinate
    var name: String?
    
    init(coordinate: Coordinate, name: String? = nil) {
        self.coordinate = coordinate
        self.name = name
    }
}
