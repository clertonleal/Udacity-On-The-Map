//
//  UdacityNetwork.swift
//  Map
//
//  Created by Clêrton Cunha Leal on 26/04/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import Foundation

class UdacityNetwork {
    func doLogin(email: String, password: String, success: @escaping (LoginResult) -> Void, errorCallback: @escaping (NetworkError) -> Void) {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONEncoder().encode(UdacityUser(email: email, password: password))
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            NetworkHandler().handleResponse(data: data, response: response, error: error, success: success, errorCallback: errorCallback)
        }
        
        task.resume()
    }
}
