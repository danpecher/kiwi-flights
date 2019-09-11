//
//  FlightViewModel.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import Foundation

struct FlightViewModel {
    
    let destination: String
    let destinationId: String
    let country: String
    let price: Double
    let departureTime: Date
    let route: [RouteItem]
    let link: String
    
    var formattedPrice: String {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.maximumFractionDigits = 0
        nf.locale = Locale.current
        return nf.string(from: NSNumber(floatLiteral: price)) ?? "–"
    }
    
    init(flight: Flight) {
        destination = flight.destinationCity
        country = flight.destinationCountry.name
        price = flight.price
        departureTime = Date(timeIntervalSince1970: TimeInterval(flight.departure))
        destinationId = flight.destinationId
        route = flight.route
        link = flight.link
    }
}
