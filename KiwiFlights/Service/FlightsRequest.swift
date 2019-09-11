//
//  FlightsRequest.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

struct FlightsRequest: Codable {
    var dateRange: ClosedRange<Date>?
    var fromLocation: String?
    var destinations: [String]?
    var onePerCity: Bool = false
    var limit: Int = 20
    var currency: String = Locale.current.currencyCode ?? "USD"
    
    init() {}
}
