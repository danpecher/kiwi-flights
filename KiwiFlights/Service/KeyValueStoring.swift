//
//  KeyValueStoring.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 11/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import Foundation

protocol KeyValueStoring {
    func set(value: Int, for key: String)
    func set(value: String, for key: String)
    func set(value: [String], for key: String)
    
    func getInt(key: String) -> Int
    func getString(key: String) -> String?
    func getArray(key: String) -> [String]
}
