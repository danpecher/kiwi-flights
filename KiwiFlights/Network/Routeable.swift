//
//  Routeable.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

protocol Routeable {
    var path: String { get }
    var query: [URLQueryItem] { get }
}
