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
    
    let geocoder = CLGeocoder()
    let spinner = SpinnerViewController()
    var location: Location! = nil
    var closeCallback: (() -> Void)! = nil
    
    override func viewWillDisappear(_ animated: Bool) {
        closeCallback()
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddLocation(_ sender: Any) {
        spinner.didMove(toParent: self)
        if let user = (UIApplication.shared.delegate as! AppDelegate).user,
            let adress = adressText.text,
            let link = linkAdress.text{
            
            showSpinner()
            geocoder.geocodeAddressString(adress) { (placemarks, error) in
                self.hideSpinner()

                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    var location: CLLocation?

                    if let placemarks = placemarks, placemarks.count > 0 {
                        location = placemarks.first?.location
                    }

                    if let location = location {
                        self.sendLocation(currentLocation: location, user: user, adress: adress, link: link)
                    } else {
                        let alert = UIAlertController(title: "Error", message: "No Matching Location Found", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    private func showSpinner() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    private func hideSpinner() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
    
    private func sendLocation(currentLocation: CLLocation, user: UdacityUser, adress: String, link: String) {
        location = Location(firstName: user.udacity.username,
                            lastName: " ",
                            longitude: currentLocation.coordinate.longitude,
                            latitude: currentLocation.coordinate.latitude,
                            uniqueKey: UUID().uuidString,
                            mediaURL: link,
                            mapString: adress)
        
        if let viewController = self.storyboard?.instantiateViewController(identifier: "finish") as? FinishAddLocationViewController {
            viewController.location = self.location
            viewController.successCallback = {
                self.dismiss(animated: true, completion: nil)
            }
            self.present(viewController, animated: true, completion: nil)
        }
    }
}
