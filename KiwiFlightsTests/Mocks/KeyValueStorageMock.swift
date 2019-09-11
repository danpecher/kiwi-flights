//
//  KeyValueStorageMock.swift
//  KiwiFlightsTests
//
//  Created by Daniel Pecher on 11/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import Foundation
@testable import KiwiFlights

class KeyValueStorageMock: KeyValueStoring {
    
    enum Scenario {
        case none
    }
    
    var scenario: Scenario = .none
    
    var intStorage = [String: Int]()
    var stringStorage = [String: String]()
    var arrayStorage = [String: [String]]()
    
    func set(value: Int, for key: String) {
        intStorage[key] = value
    }
    
    func set(value: String, for key: String) {
        stringStorage[key] = value
    }
    
    func set(value: [String], for key: String) {
        arrayStorage[key] = value
    }
    
    func getInt(key: String) -> Int {
        return intStorage[key] ?? 0
    }
    
    func getString(key: String) -> String? {
        return stringStorage[key]
    }
    
    func getArray(key: String) -> [String] {
        return arrayStorage[key] ?? []
    }
}
