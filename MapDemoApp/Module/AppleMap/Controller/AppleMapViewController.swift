//
//  AppleMapViewController.swift
//  MapDemoApp
//
//  Created by JungpyoHong on 4/24/21.
//


import UIKit
import MapKit

class AppleMapViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
            mapView.showsUserLocation = true
        }
    }
    @IBOutlet private weak var searchBar:  UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    var locationManager = CLLocationManager()
    let viewModel = MapViewModel()
    
    var location: CLLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        viewModel.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        centerToLocation(location: mapView.userLocation)
        
        let annotation = MyPoint(coordinate: CLLocationCoordinate2D(latitude: 40.759211, longitude: -73.984638))
        annotation.title = "my annotation title"
        annotation.subtitle = "my annotation subtitle"
        mapView.addAnnotation(annotation)
        
    }
    // 맵에 얼마나 보이는지
    private func centerToLocation(location: MKUserLocation) {
        
        guard let location = self.location else { return }
        mapView.centerTo(location: location, withRadius: 1000)
    }
}

extension AppleMapViewController: UISearchBarDelegate {
    //search bar 사용해줄때 사용되는 delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    //서치바를 누르면 키보드가 나온다
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search(query: searchBar.text ?? "", in: mapView.region)
    }
}

extension AppleMapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    //이걸로 계속 맵을  업데이트 해준다
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        centerToLocation(location: userLocation)
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailScreen = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        detailScreen.detailView = view
        self.navigationController?.pushViewController(detailScreen, animated: true)
        
    }
    //     modify the annotation
    //     내가 만들어준 mypoint 를 annotation 으로 사용해주는(model window 에다가 알려줄수있다) delegate method 이다
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let myAnnotation = annotation as? MyPoint else { return nil }
        let identifier = "MyAnnotation"
        // MKMarkerAnnotationView -> annotation 에서 information 을 보여주는것이다
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = myAnnotation
            view = dequeuedView
            view.annotation = annotation
            // https://stackoverflow.com/questions/58989265/mkmarkerannotationview-not-showing-callout
        } else {
            let markerView =  MKMarkerAnnotationView(annotation: myAnnotation, reuseIdentifier: identifier)
            view = markerView
            // 핀을 누르면 그 위에뜨는 조그마한 말풍선을 듯한다
            view.canShowCallout = true
            let infoButton = UIButton(type: .detailDisclosure)
            view.rightCalloutAccessoryView = infoButton
        }
        return view
    }
}
// MKLocationSearch -> you can search map
// annotation clustering - 줌인 줌아웃을했을떄 annotation이 바뀐다(merge into one or more detail)

extension AppleMapViewController: MapViewModelDelegate {
    func clearAnnotation() {
        mapView.removeAnnotations(viewModel.annotationsForMap())
    }
    
    func didFetchSearch() {
        mapView.addAnnotations(viewModel.annotationsForMap())
    }
    
    func didFail(with error: MapViewModel.MapError) {
    }
}

