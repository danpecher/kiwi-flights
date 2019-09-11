//
//  APIResponse.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

struct APIResponse<Model>: Decodable where Model: Decodable {
    var data: Model
}
