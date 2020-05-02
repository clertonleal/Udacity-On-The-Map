//
//  UdacityUser.swift
//  Map
//
//  Created by Clêrton Cunha Leal on 26/04/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import Foundation

struct UdacityUser: Codable {
    let udacity: User
    
    init(email: String, password: String) {
        self.udacity = User(username: email, password: password)
    }
}
