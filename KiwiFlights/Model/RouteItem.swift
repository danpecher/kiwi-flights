//
//  RouteItem.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 11/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import Foundation

struct RouteItem: Decodable {
    let departure: Int
    let arrival: Int
    let cityFrom: String
    let cityTo: String
    
    enum CodingKeys: String, CodingKey {
        case arrival = "aTime"
        case departure = "dTime"
        case cityFrom
        case cityTo
    }
}
