//
//  SecondViewController.swift
//  Map
//
//  Created by Clêrton Cunha Leal on 26/04/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var locations: [Location] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (UIApplication.shared.delegate as! AppDelegate).shouldReloadList {
            loadLocations()
            (UIApplication.shared.delegate as! AppDelegate).shouldReloadList = false
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
        cell.selectionStyle = .none
        let location = self.locations[indexPath.row]
        cell.userNameLabel.text = "\(location.firstName) \(location.lastName)"
        cell.userLinkLabel.text = location.mediaURL
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: locations[indexPath.row].mediaURL) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        UdacityNetwork().logout(success: {success in
            self.dismiss(animated: true, completion: nil)
        }, errorCallback: {error in
            let alert = UIAlertController(title: "Error", message: error.error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func onReload(_ sender: Any) {
        loadLocations()
    }
    
    @IBAction func onAddLocation(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(identifier: "newLocation") as? AddLocationViewController {
            viewController.closeCallback = {
                self.loadLocations()
            }
            present(viewController, animated: true, completion: nil)
        }
    }
    
    private func loadLocations() {
        UdacityNetwork().getLocations(success: { locations in
            self.locations = locations.results
            self.tableView.reloadData()
        }, errorCallback: { error in
            let alert = UIAlertController(title: "Error", message: error.error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        })
    }
    
}

