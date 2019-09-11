//
//  MockFlightService.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit
@testable import KiwiFlights

class MockFlightService: FlightServicing {
    func getFlights(request: FlightsRequest, completion: @escaping (Result<[Flight], Error>) -> Void) {
        completion(.success([
            Flight(id: "1", price: 100, destinationCity: "Paris", departure: 213, destinationId: "2", destinationCountry: Country(name: "France", code: "FR"), airport: "ABC", route: [], link: ""),
        ]))
    }
}
