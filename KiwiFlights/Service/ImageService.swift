//
//  ImageService.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

class ImageService {
    
    enum ImageSize {
        case thumbnail, large
        
        var resolution: String {
            switch self {
            case .thumbnail: return "600x330"
            case .large: return "1280x720"
            }
        }
    }
    
    private var cache = NSCache<NSString, UIImage>()
    
    private var baseUrl = "https://images.kiwi.com/photos"
    
    static var shared: ImageService = {
        return ImageService()
    }()
    
    func getImage(destinationId: String, size: ImageSize, completion: @escaping (UIImage) -> Void) {
        
        let url = "\(baseUrl)/\(size.resolution)/\(destinationId).jpg"
        
        if let existing = cache.object(forKey: NSString(string: url)) {
            completion(existing)
            return
        }
        
        URLSession.shared.dataTask(with: URL(string: url)!) { [weak self] (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            self?.cache.setObject(image, forKey: NSString(string: url))
            
            completion(image)
        }.resume()
    }
}
