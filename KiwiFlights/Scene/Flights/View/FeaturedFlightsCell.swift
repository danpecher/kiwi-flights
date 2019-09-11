//
//  FeaturedFlightsCell.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 08/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit


class FeaturedFlightsCell: UITableViewCell {

    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var containerView: UIView!
    
    var viewModel: FlightViewModel! {
        didSet {
            titleLabel.text = viewModel.destination
            priceLabel.text = viewModel.formattedPrice
            dateLabel.text = viewModel.departureTime.formatted
            
            ImageService.shared.getImage(destinationId: viewModel.destinationId, size: .thumbnail) { [weak self] image in
                DispatchQueue.main.async {
                    self?.backgroundImage.image = image
                }
            }
        }
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.4).cgColor]
        gradientLayer.locations = [0.5, 1]
        return gradientLayer
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 10

        containerView.clipsToBounds = true
        gradientView.layer.addSublayer(gradientLayer)
        
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 1)
        shadowView.layer.shadowOpacity = 0.4
        shadowView.layer.shadowRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutSubviews()
        
        gradientLayer.frame = containerView.bounds
    }
}
