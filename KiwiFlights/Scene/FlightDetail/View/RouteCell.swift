//
//  RouteCell.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 11/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

struct FlightDuration {
    
    enum Unit {
        case day(Int), hour(Int), minute(Int)
        
        var unitCharacter: String {
            switch self {
            case .day: return "d"
            case .hour: return "h"
            case .minute: return "m"
            }
        }
        
        var value: Int {
            switch self {
            case let .day(value): return value
            case let .hour(value): return value
            case let .minute(value): return value
            }
        }
    }
    
    init(duration: Int) {
        self.days = .day(duration / (3600 * 24))
        self.hours = .hour(duration / 3600)
        self.minutes = .minute((duration % 3600) / 60)
    }
    
    let days: Unit
    let hours: Unit
    let minutes: Unit
    
    var formatted: String {
        return [days, hours, minutes].reduce(into: "") { (result, item) in
            if item.value > 0 {
                result += "\(item.value)\(item.unitCharacter)"
            }
        }
    }
}

class RouteCell: UITableViewCell {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var departureLabel: UILabel!
    @IBOutlet private weak var fromLabel: UILabel!
    @IBOutlet private weak var arrivalLabel: UILabel!
    @IBOutlet private weak var toLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    var viewModel: RouteItem! {
        didSet {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            
            departureLabel.text = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(viewModel.departure)))
            fromLabel.text = viewModel.cityFrom
            toLabel.text = viewModel.cityTo
            arrivalLabel.text = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(viewModel.arrival)))
            
            let duration = viewModel.arrival - viewModel.departure
            durationLabel.text = FlightDuration(duration: duration).formatted
        }
    }
}
