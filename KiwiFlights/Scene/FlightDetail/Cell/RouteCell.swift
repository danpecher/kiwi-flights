//
//  RouteCell.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 11/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

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
            
            let hours = (viewModel.arrival - viewModel.departure) / 3600
            let minutes = ((viewModel.arrival - viewModel.departure) % 3600) / 60
            durationLabel.text = "\(hours)h\(minutes)m"
        }
    }
}
