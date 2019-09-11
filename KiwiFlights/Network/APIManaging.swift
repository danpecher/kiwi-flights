//
//  APIManaging.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import Foundation

protocol APIManaging {
    func request<Model: Decodable>(route: Routeable, completion: @escaping (Result<Model, Error>) -> Void)
}
