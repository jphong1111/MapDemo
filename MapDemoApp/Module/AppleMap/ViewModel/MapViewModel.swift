//
//  MapViewModel.swift
//  MapDemoApp
//
//  Created by JungpyoHong on 4/24/21.
//

import MapKit

protocol MapViewModelDelegate: AnyObject {
    func didFetchSearch()
    func didFail(with error: MapViewModel.MapError)
    func clearAnnotation()
}

class MapViewModel: NSObject {
    enum MapError: Error {
        case emptySearchField
        case localSearchField
        case emptyResult
        static func parseError(error: Error) -> Self {
            .localSearchField
        }
        
    }
    private var results = [MyPoint]() {
        didSet {
            self.delegate?.didFetchSearch()
        }
    }
    weak var delegate: MapViewModelDelegate?
    
    func annotationsForMap() -> [MyPoint] {
        return results
    }
    
    func search(query: String, in region: MKCoordinateRegion) {
        let searchQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !searchQuery.isEmpty else {
            self.delegate?.didFail(with: .emptySearchField)
            return
        }
        performSearch(with: searchQuery, in: region)
    }
    
    private func performSearch(with query: String, in region: MKCoordinateRegion) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = region
        request.resultTypes = [.pointOfInterest]
        request.pointOfInterestFilter = MKPointOfInterestFilter(including: [.cafe])
        let search = MKLocalSearch(request: request) // MKLocalSearch -> 큰도시들에서만 사용하는게좋다 작은도시들은 나오지않는다
        search.start { [weak self] response, error in
            guard error == nil, let results = response else {
                self?.delegate?.didFail(with: .localSearchField)
                return
            }
            guard results.mapItems.count != 0 else {
                self?.delegate?.didFail(with: .emptyResult)
                return
            }
            let annotations = results.mapItems.map { mapItem -> MyPoint in
                let annotation = MyPoint(coordinate: mapItem.placemark.coordinate)
                annotation.title = mapItem.name
                annotation.subtitle = mapItem.phoneNumber
                return annotation
            }
            self?.delegate?.clearAnnotation()
            self?.results = annotations
        }
    }
}
extension MapViewModel: MKLocalSearchCompleterDelegate {
    // Get location from location
    func getLocationName(with location: CLLocation, completion: @escaping ((String?) -> Void)) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, preferredLocale: .current) { place, error in
            guard let place = place?.last, error == nil else {
                completion("")
                return
            }
            let joinedAddressArray =  [place.thoroughfare, place.locality, place.administrativeArea, place.country, place.postalCode].compactMap { $0 }.joined(separator: " ")
            
            print("Address: \(joinedAddressArray)")
            completion(joinedAddressArray)
        }
        
    }
}
