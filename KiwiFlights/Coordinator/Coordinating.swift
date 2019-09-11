//
//  Coordinating.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import Foundation

protocol Coordinating {
    var children: [Coordinating] { get set }
    
    func start()
}
