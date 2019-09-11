//
//  FlightDetailViewController.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

class FlightDetailViewController: UIViewController {

    @IBOutlet private weak var imageHeight: NSLayoutConstraint!
    @IBOutlet private weak var destinationImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var buyButton: UIButton!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.rowHeight = 80
            tableView.register(UINib(nibName: "RouteCell", bundle: .main), forCellReuseIdentifier: "RouteCell")
            tableView.register(UINib(nibName: "SimpleDateCell", bundle: .main), forCellReuseIdentifier: "SimpleDateCell")
            tableView.separatorColor = .clear
        }
    }
    
    var viewModel: FlightViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = "Flight to \(viewModel.destination), \(viewModel.country) on \(viewModel.departureTime.formatted)"

        ImageService.shared.getImage(destinationId: viewModel.destinationId, size: .large) { [weak self] image in
            DispatchQueue.main.async {
                self?.destinationImage.image = image
            }
        }
        
        buyButton.layer.cornerRadius = 5
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let formattedPrice = formatter.string(from: NSNumber(value: viewModel.price)) {
            
            let attributed = NSMutableAttributedString(string: "Buy for ", attributes: [
                .font: UIFont(name: "Circular-Book", size: 18)!,
                .foregroundColor: UIColor.white
            ])
            attributed.append(NSAttributedString(string: "\(formattedPrice)", attributes: [
                .font: UIFont(name: "Circular-Bold", size: 18)!,
                .foregroundColor: UIColor.white
            ]))
            
            buyButton.setAttributedTitle(attributed, for: .normal)
        }
    }
    
    @IBAction func buyButtonPressed(_ sender: UIButton) {
        guard let link = viewModel?.link, let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension FlightDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Itinerary"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.route.count ?? 0) + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleDateCell", for: indexPath) as? SimpleDateCell, let item = viewModel?.route.first else { fatalError() }
            
            cell.titleLabel.text = Date(timeIntervalSince1970: TimeInterval(item.departure)).formatted
            cell.descriptionLabel.text = "Start"
            
            return cell
        }
        
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleDateCell", for: indexPath) as? SimpleDateCell, let item = viewModel?.route.last else { fatalError() }
            
            cell.titleLabel.text = Date(timeIntervalSince1970: TimeInterval(item.arrival)).formatted
            cell.descriptionLabel.text = "End"
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RouteCell", for: indexPath) as? RouteCell, let item = viewModel?.route[indexPath.row-1] else { fatalError() }
        
        cell.viewModel = item
        
        return cell
    }
}
