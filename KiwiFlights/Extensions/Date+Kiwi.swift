//
//  Date+Kiwi.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
