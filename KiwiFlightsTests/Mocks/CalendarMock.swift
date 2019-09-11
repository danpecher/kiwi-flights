//
//  CalendarMock.swift
//  KiwiFlightsTests
//
//  Created by Daniel Pecher on 11/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import Foundation
@testable import KiwiFlights

class CalendarMock: CurrentDayProviding {
    
    enum Scenario {
        case day(Int)
    }
    
    var scenario: Scenario
    
    init(_ scenario: Scenario = .day(0)) {
        self.scenario = scenario
    }
    
    var currentWeekDay: Int {
        switch scenario {
        case let .day(day): return day
        }
    }
}
