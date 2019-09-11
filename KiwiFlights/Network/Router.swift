//
//  Router.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

enum QueryItem: String {
    case dateFrom, dateTo, flyFrom, partner, limit, sort, onePerCity = "one_for_city", currency = "curr", locale, asc
}

enum Router: Routeable {
    case flights(FlightsRequest)
    
    var path: String {
        switch self {
        case .flights:
            return "/flights"
        }
    }
    
    var query: [URLQueryItem] {
        switch self {
        case let .flights(request):
            
            var queryItems: [QueryItem: String] = [
                .partner: "weekend-app",
                .limit: String(request.limit),
                .sort: "quality",
                .currency: request.currency,
                .onePerCity: request.onePerCity ? "1" : "0",
                .locale: Locale.current.languageCode ?? "en",
                .asc: "0"
            ]
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/Y"
            
            if let dateRange = request.dateRange {
                queryItems[.dateFrom] = dateFormatter.string(from: dateRange.lowerBound)
                queryItems[.dateTo] = dateFormatter.string(from: dateRange.upperBound)
            }
            
            if let fromLocation = request.fromLocation {
                queryItems[.flyFrom] = fromLocation
            }
            
            return queryItems.map { URLQueryItem(name: $0.key.rawValue, value: $0.value) }
        }
    }
}
