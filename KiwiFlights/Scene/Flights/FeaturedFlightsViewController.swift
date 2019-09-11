//
//  FeaturedFlightsViewController.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 07/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

class FeaturedFlightsViewController: UIViewController {
    
    weak var coordinator: FeaturedFlightsCoordinator?

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "FeaturedFlightsCell", bundle: .main), forCellReuseIdentifier: "FeaturedFlightsCell")
            tableView.register(UINib(nibName: "FeaturedFlightsFooter", bundle: .main), forHeaderFooterViewReuseIdentifier: "FeaturedFlightsFooter")
            tableView.refreshControl = refreshControl
        }
    }
    
    lazy private var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        return refreshControl
    }()
    
    var viewModel: FeaturedFlightsViewModeling! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Flight Offers"
        
        refreshControl.beginRefreshing()
        refresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        refresh()
    }
    
    @objc func refresh() {
        viewModel.getFlights()
    }
}

extension FeaturedFlightsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedFlightsCell", for: indexPath) as? FeaturedFlightsCell else { fatalError("Cell dequeue") }
        
        cell.viewModel = FlightViewModel(flight: viewModel.items[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

extension FeaturedFlightsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigateToDetail(flight: viewModel.items[indexPath.row])
    }
}

extension FeaturedFlightsViewController: FeaturedFlightsViewModelDelegate {
    func didReceiveFlights() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
            
            self?.tableView.tableFooterView = self?.tableView.dequeueReusableHeaderFooterView(withIdentifier: "FeaturedFlightsFooter")
        }
    }
    
    func didFail(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
            
            let alert = UIAlertController(title: "Error", message: "An error occurred while making a request.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK ☹️", style: .cancel))
            self?.present(alert, animated: true)
        }
        print(error.localizedDescription)
    }
}
