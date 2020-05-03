//
//  AddLocationViewController.swift
//  Map
//
//  Created by Clêrton Cunha Leal on 02/05/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class AddLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var adressText: UITextField!
    @IBOutlet weak var linkAdress: UITextField!
    
    let manager = CLLocationManager()
    var coordinate: CLLocationCoordinate2D? = nil
    var location: Location! = nil
    
    override func viewDidLoad() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            coordinate = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        } else if status == .denied {
            let alert = UIAlertController(title: "Error", message: "Is necessary grant location permission to use this functionality", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func onAddLocation(_ sender: Any) {
        if let user = (UIApplication.shared.delegate as! AppDelegate).user,
            let adress = linkAdress.text,
            let link = adressText.text,
            let coordinate = coordinate {
            
            location = Location(firstName: user.udacity.username,
                                lastName: " ",
                                longitude: coordinate.longitude,
                                latitude: coordinate.latitude,
                                uniqueKey: UUID().uuidString,
                                mediaURL: adress,
                                mapString: link)
            
            dismiss(animated: true, completion: {
                
                let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                
                if var topController = keyWindow?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }
                    
                    if let viewController = self.storyboard?.instantiateViewController(identifier: "finish") as? FinishAddLocationViewController {
                        viewController.location = self.location
                        topController.present(viewController, animated: true, completion: nil)
                    }
                }
            })
        }
    }
}
