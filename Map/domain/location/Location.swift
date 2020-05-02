//
//  Location.swift
//  Map
//
//  Created by Clêrton Cunha Leal on 02/05/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import Foundation

struct Location: Codable {
    let firstName: String
    let lastName: String
    let longitude: Double
    let latitude: Double
    let uniqueKey: String
    let mediaURL: String
    let mapString: String
}
