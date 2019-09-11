//
//  APIManager.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

class APIManager: APIManaging {
    
    let apiUrl: String
    
    init(apiUrl: String) {
        self.apiUrl = apiUrl
    }
    
    func request<Model: Decodable>(route: Routeable, completion: @escaping (Result<Model, Error>) -> Void) {
        
        var components = URLComponents(string: apiUrl)!
        
        components.path = route.path
        components.queryItems = route.query
        
        guard let url = components.url else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(AppError.emptyData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            do {
                completion(.success(try decoder.decode(Model.self, from: data)))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
