//
//  DailyOffersManager.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 11/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import Foundation

protocol CurrentDayProviding {
    var currentWeekDay: Int { get }
}

extension Calendar: CurrentDayProviding {
    var currentWeekDay: Int {
        return dateComponents([.day], from: Date(timeIntervalSinceNow: 0)).day ?? 0
    }
}

class DailyOffersManager {
    
    private var storage: KeyValueStoring
    private var calendar: CurrentDayProviding
    
    init(storage: KeyValueStoring, calendar: CurrentDayProviding) {
        self.storage = storage
        self.calendar = calendar
    }
    
    enum StorageKey: String {
        case currentFlights
        case seenAirports
        case currentDay
    }
    
    private var isAnotherDay: Bool {
        return currentDay != storage.getInt(key: StorageKey.currentDay.rawValue)
    }
    
    private var seenAirports: [String] {
        return storage.getArray(key: StorageKey.seenAirports.rawValue)
    }
    
    private var currentDay: Int {
        return calendar.currentWeekDay
    }
    
    func getFlightsForToday(from flightsPool: [Flight]) -> [Flight] {
        
        let currentFlights = storage.getArray(key: StorageKey.currentFlights.rawValue)
        
        if isAnotherDay || currentFlights.isEmpty {
            
            let seenAirports = self.seenAirports
            
            let unseenFlights = flightsPool
                .filter { !seenAirports.contains($0.airport) }
            let flights = unseenFlights[0...min(4, unseenFlights.count)]
            
            storage.set(value: seenAirports + flights.map { $0.airport }, for: StorageKey.seenAirports.rawValue)
            storage.set(value: currentDay, for: StorageKey.currentDay.rawValue)
            storage.set(value: flights.map { $0.id }, for: StorageKey.currentFlights.rawValue)
            
            return Array(flights)
        }
        
        return flightsPool.filter { flight in
            currentFlights.contains { flight.id == $0 }
        }
    }
}

