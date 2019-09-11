//
//  FeaturedFlightsCoordinator.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

class FeaturedFlightsCoordinator: Coordinating {
    var children: [Coordinating] = []
    var navigationController: UINavigationController
    var container: DependencyInjection
    
    init(navigationController: UINavigationController, container: DependencyInjection) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let controller = container.resolve(type: FeaturedFlightsViewController.self)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: false)
    }
    
    func navigateToDetail(flight: Flight) {
        let controller = container.resolve(type: FlightDetailViewController.self)
        controller.viewModel = FlightViewModel(flight: flight)
        controller.modalPresentationStyle = .fullScreen
        navigationController.present(controller, animated: true)
    }
}
