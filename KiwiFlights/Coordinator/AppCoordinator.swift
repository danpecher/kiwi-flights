//
//  AppCoordinator.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 07/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinating {
    
    weak var window: UIWindow?
    
    var children = [Coordinating]()

    lazy private var container: DependencyInjection = DependencyInjection()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        container.register(type: APIManaging.self) { _ in
            return APIManager(apiUrl: "https://api.skypicker.com")
        }
        
        container.register(type: FlightServicing.self) { c in
            // return MockFlightService()
            return FlightService(apiManager: c.resolve(type: APIManaging.self))
        }
        
        container.register(type: KeyValueStoring.self) { _ in
            return UserDefaults.standard
        }
        
        container.register(type: DailyOffersManager.self) { c in
            return DailyOffersManager(
                storage: c.resolve(type: KeyValueStoring.self),
                calendar: Calendar.current
            )
        }
        
        container.register(type: FeaturedFlightsViewModeling.self) { c in
            let vm = FeaturedFlightsViewModel(
                flightService: c.resolve(type: FlightServicing.self),
                dailyOffersManager: c.resolve(type: DailyOffersManager.self)
            )
            
            return vm
        }
        
        container.register(type: FlightDetailViewController.self) { _ in
            guard let vc = UIStoryboard(name: "FlightDetailViewController", bundle: .main).instantiateInitialViewController() as? FlightDetailViewController else { fatalError("Couldn't initialize view controller") }
            return vc
        }
        
        container.register(type: FeaturedFlightsViewController.self) { c in
            guard let vc = UIStoryboard(name: "FeaturedFlightsViewController", bundle: .main).instantiateInitialViewController() as? FeaturedFlightsViewController else { fatalError("Couldn't initialize view controller") }
            
            vc.viewModel = c.resolve(type: FeaturedFlightsViewModeling.self)
            
            return vc
        }
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "Circular-bold", size: 17)!
        ]
        
        window?.rootViewController = navigationController
        let coordinator = FeaturedFlightsCoordinator(navigationController: navigationController, container: container)
        children.append(coordinator)
        coordinator.start()
        
        window?.makeKeyAndVisible()
    }
}
