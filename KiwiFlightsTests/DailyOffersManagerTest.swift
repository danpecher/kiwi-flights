//
//  DailyOffersManagerTest.swift
//  DailyOffersManagerTest
//
//  Created by Daniel Pecher on 11/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import XCTest
@testable import KiwiFlights

class DailyOffersManagerTest: XCTestCase {
    
    private var flightsPool: [Flight] {
        return (0...20).map {
            Flight(id: String($0), price: Double(100 * $0), destinationCity: "City \($0)", departure: 123, destinationId: "ABC", destinationCountry: Country(name: "Country \($0)", code: String($0)), airport: "AB\($0)", route: [], link: "")
        }
    }

    func testFirstRun() {
        let storage = KeyValueStorageMock()
        let subject = DailyOffersManager(storage: storage, calendar: CalendarMock())
        
        let flights = subject.getFlightsForToday(from: flightsPool)
        
        let expectedFlightsCount = 5
        let seenDestinations = storage.getArray(key: DailyOffersManager.StorageKey.seenAirports.rawValue)
        XCTAssertEqual(flights.count, expectedFlightsCount)
        XCTAssertEqual(seenDestinations, ["AB0", "AB1", "AB2", "AB3", "AB4"])
    }
    
    func testSecondRunSameDay() {
        let storage = KeyValueStorageMock()
        let currentFlightsIds = ["3", "4", "5", "6", "7"]
        storage.arrayStorage[DailyOffersManager.StorageKey.currentFlights.rawValue] = currentFlightsIds
        storage.intStorage[DailyOffersManager.StorageKey.currentDay.rawValue] = 0
        
        let subject = DailyOffersManager(storage: storage, calendar: CalendarMock(.day(0)))
        
        let flights = subject.getFlightsForToday(from: flightsPool)
        
        XCTAssertEqual(currentFlightsIds, flights.map { $0.id })
    }
    
    func testSecondRunSameDayFlightMissing() {
        let storage = KeyValueStorageMock()
        let currentFlightsIds = ["3", "4", "5", "6", "7"]
        var flightsPool = self.flightsPool
        flightsPool.removeAll { $0.id == "5" }
        
        storage.arrayStorage[DailyOffersManager.StorageKey.currentFlights.rawValue] = currentFlightsIds
        storage.intStorage[DailyOffersManager.StorageKey.currentDay.rawValue] = 0
        
        let subject = DailyOffersManager(storage: storage, calendar: CalendarMock(.day(0)))
        
        let flights = subject.getFlightsForToday(from: flightsPool)
        
        XCTAssertEqual(["3", "4", "6", "7"], flights.map { $0.id })
    }
    
    func testNextDay() {
        let storage = KeyValueStorageMock()
        let currentFlightsIds = ["3", "4", "5", "6", "7"]
        
        storage.arrayStorage[DailyOffersManager.StorageKey.currentFlights.rawValue] = currentFlightsIds
        storage.intStorage[DailyOffersManager.StorageKey.currentDay.rawValue] = 0
        storage.arrayStorage[DailyOffersManager.StorageKey.seenAirports.rawValue] = ["AB0", "AB1", "AB2", "AB3", "AB4"]
        
        let subject = DailyOffersManager(storage: storage, calendar: CalendarMock(.day(1)))
        
        let seenAirports = storage.getArray(key: DailyOffersManager.StorageKey.seenAirports.rawValue)
        let flights = subject.getFlightsForToday(from: flightsPool)
        
        XCTAssertEqual(0, flights.filter { seenAirports.contains($0.airport) }.count)
        XCTAssertEqual(
            ["AB0", "AB1", "AB2", "AB3", "AB4", "AB5", "AB6", "AB7", "AB8", "AB9"],
            storage.getArray(key: DailyOffersManager.StorageKey.seenAirports.rawValue)
        )
    }
}
