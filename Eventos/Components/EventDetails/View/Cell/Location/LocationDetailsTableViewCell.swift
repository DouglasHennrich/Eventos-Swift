//
//  LocationDetailsTableViewCell.swift
//  Eventos
//
//  Created by Douglas Hennrich on 26/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit
import MapKit
//import CoreLocation

class LocationDetailsTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.showsUserLocation = false
        }
    }
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        mapView.removeAnnotations(mapView.annotations)
        super.prepareForReuse()
    }
    
    deinit {
        mapView.removeAnnotations(mapView.annotations)
        mapView.delegate = nil
    }
    
    // MARK: Config
    func config(with coords: [String: Any]) {
        guard let latitude = coords["latitude"] as? Double,
            let longitude = coords["longitude"] as? Double
            else {
                return
        }

        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let location = CLLocationCoordinate2DMake(latitude, longitude)

        let region = MKCoordinateRegion(center: location, span: span)

        mapView.setRegion(region, animated: false)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
    
}
