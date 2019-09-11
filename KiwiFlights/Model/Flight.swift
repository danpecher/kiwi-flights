//
//  Flight.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 07/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import Foundation

struct Flight: Decodable {
    
    let id: String
    let price: Double
    let destinationCity: String
    let departure: Int
    let destinationId: String
    let destinationCountry: Country
    let airport: String
    let route: [RouteItem]
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case price
        case destinationCity = "cityTo"
        case airport = "flyTo"
        case departure = "dTime"
        case destinationId = "mapIdto"
        case destinationCountry = "countryTo"
        case route
        case link = "deep_link"
    }
}
