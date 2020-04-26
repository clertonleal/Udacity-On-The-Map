//
//  NertworkError.swift
//  Map
//
//  Created by Clêrton Cunha Leal on 26/04/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import Foundation

struct NetworkError: Codable {
    let status: Int
    let error: String
}
