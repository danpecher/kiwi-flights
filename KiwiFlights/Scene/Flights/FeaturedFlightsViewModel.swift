//
//  FeaturedFlightsViewModel.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

class FeaturedFlightsViewModel: FeaturedFlightsViewModeling {
    
    var delegate: FeaturedFlightsViewModelDelegate?
    var flightService: FlightServicing
    var dailyOffersManager: DailyOffersManager
    
    var items: [Flight] = []
    
    private var currentDay: Int {
        return Calendar.current.dateComponents([.day], from: Date(timeIntervalSinceNow: 0)).day ?? 0
    }
    
    init(flightService: FlightServicing, dailyOffersManager: DailyOffersManager) {
        self.flightService = flightService
        self.dailyOffersManager = dailyOffersManager
    }
    
    func getFlights() {
        
        var request = FlightsRequest()
        request.fromLocation = "PRG"
        request.onePerCity = true
        request.limit = 50
        
        flightService.getFlights(request: request) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case let .success(flights):

                self.items = self.dailyOffersManager.getFlightsForToday(from: flights)
                
                self.delegate?.didReceiveFlights()
                
            case let .failure(error):
                self.delegate?.didFail(error: error)
            }
        }
    }
}
