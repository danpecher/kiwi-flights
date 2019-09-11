//
//  FeaturedFlightsViewModeling.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import Foundation

protocol FeaturedFlightsViewModelDelegate {
    func didReceiveFlights()
    func didFail(error: Error)
}

protocol FeaturedFlightsViewModeling {
    var delegate: FeaturedFlightsViewModelDelegate? { get set }
    var items: [Flight] { get set }
    
    func getFlights()
}
