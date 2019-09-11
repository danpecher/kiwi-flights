//
//  DependencyInjection.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import Foundation

class DependencyInjection {
    
    private var items = [String: (DependencyInjection) -> Any]()
    
    func register<T>(type: T.Type, registration: @escaping (DependencyInjection) -> Any) {
         items[String(describing: type)] = registration
    }
    
    func resolve<T>(type: T.Type) -> T {
        return items[String(describing: type)]!(self) as! T
    }
    
}
