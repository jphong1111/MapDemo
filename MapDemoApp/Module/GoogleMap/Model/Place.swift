//
//  Place.swift
//  MapDemoApp
//
//  Created by JungpyoHong on 4/25/21.
//

import Foundation

struct Place: Codable {
    let results: [Results]
}

struct Results: Codable {
    let businessStatus: String
    let icon: String
    let name: String
    let priceLevel: Int
    let rating: Double
}

enum MovieCodingKeys: String, CodingKey {
      case businessStatus = "business_status"
      case icon
      case name
      case priceLevel = "price_level"
      case rating
  }
