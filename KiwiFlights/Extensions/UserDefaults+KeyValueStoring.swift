//
//  UserDefaults+KeyValueStoring.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 11/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import Foundation

extension UserDefaults: KeyValueStoring {
    func set(value: Int, for key: String) {
        set(value, forKey: key)
    }
    
    func set(value: String, for key: String) {
        set(value, forKey: key)
    }
    
    func set(value: [String], for key: String) {
        set(value, forKey: key)
    }
    
    func getInt(key: String) -> Int {
        return integer(forKey: key)
    }
    
    func getString(key: String) -> String? {
        return string(forKey: key)
    }
    
    func getArray(key: String) -> [String] {
        return array(forKey: key) as? [String] ?? []
    }
}
