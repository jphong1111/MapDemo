//
//  DetailViewController.swift
//  MapDemoApp
//
//  Created by JungpyoHong on 4/24/21.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var placeName: UILabel!
    
    var detailView: MKAnnotationView?
    var viewModel = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetailData()
    }
    
    func fetchDetailData() {
        guard let coordinate = detailView?.annotation?.coordinate else { return }
        let searchedView = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        viewModel.getLocationName(with: searchedView) { [weak self] result in
            self?.placeName.text = result
        }
    }
}
