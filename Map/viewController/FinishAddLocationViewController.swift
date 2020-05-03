//
//  FinishAddLocationViewController.swift
//  Map
//
//  Created by Clêrton Cunha Leal on 02/05/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class FinishAddLocationViewController: UIViewController, MKMapViewDelegate {
    
    var location: Location! = nil
    var successCallback: (() -> Void)! = nil
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        mapView.delegate = self
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        let point = MKPointAnnotation()
        point.title = "\(location.firstName)"
        point.subtitle = location.mediaURL
        point.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        mapView.addAnnotation(point)
        mapView.centerCoordinate = point.coordinate
        mapView.selectAnnotation(point, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onFinish(_ sender: Any) {
        UdacityNetwork().createLocation(location: location, success: { success in
            let alert = UIAlertController(title: "Success", message: "Location created", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { success in
                self.dismiss(animated: true, completion: nil)
                self.successCallback()
            }))
            self.present(alert, animated: true)
        }, errorCallback: { error in
            let alert = UIAlertController(title: "Error", message: error.error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        })
    }
    
}
