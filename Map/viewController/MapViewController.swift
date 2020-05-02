//
//  FirstViewController.swift
//  Map
//
//  Created by Clêrton Cunha Leal on 26/04/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        mapView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UdacityNetwork().getLocations(success: { locations in
            for location in locations.results {
                let point = MKPointAnnotation()
                point.title = "\(location.firstName) \(location.lastName)"
                point.subtitle = location.mediaURL
                point.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                self.mapView.addAnnotation(point)
            }
        }, errorCallback: { error in
            let alert = UIAlertController(title: "Error", message: error.error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        })
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation, let url = URL(string: annotation.subtitle!!) {
            UIApplication.shared.open(url)
        }
    }
    
    

}

