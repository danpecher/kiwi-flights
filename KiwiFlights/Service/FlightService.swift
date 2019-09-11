//
//  FlightService.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 07/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import Foundation

class FlightService: FlightServicing {
    
    let apiManager: APIManaging
    
    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }
    
    func getFlights(request: FlightsRequest, completion: @escaping (Result<[Flight], Error>) -> Void) {
        
        apiManager.request(route: Router.flights(request)) { (result: Result<APIResponse<[Flight]>, Error>) in
            
            switch result {
                
            case let .success(response):
                completion(.success(response.data))
            case let .failure(error):
                print(error)
            }
        }
    }
    
}
