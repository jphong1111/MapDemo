//
//  AppError.swift
//  MapDemoApp
//
//  Created by JungpyoHong on 4/25/21.
//

import UIKit

enum AppError: Error {
    case badUrl
    case badResponse
    case serverError
    case noData
    case parseError
    case badRequest
    case genericError(String)
    
    var errorMessage: String {
        switch self {
        case .badUrl:
            return ""
        case .badResponse:
            return ""
        case .serverError:
            return ""
        case .noData:
            return ""
        case .parseError:
            return ""
        case .badRequest:
            return ""
        case .genericError(let message):
            return message
        }
    }
}

enum LocationError: Error {
    case locationManagerRequestFail
    case noLocationConfigured
    case localSearchRequestFail
    case localSearchCompleterFail
    
    var localizedDescription: String {
        switch self {
        case .locationManagerRequestFail:
            return "Location Error: Fail to get current location"
        case .noLocationConfigured:
            return "Location Error: WeatherViewController has no location"
        case .localSearchRequestFail:
            return "Local Search Request Error : No corresoponding location data for user selection"
        case .localSearchCompleterFail:
            return "Local search completer is unable to generate a list of search results"
        }
    }
    
}
