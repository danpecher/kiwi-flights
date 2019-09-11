//
//  DottedView.swift
//  KiwiFlights
//
//  Created by Daniel Pecher on 11/09/2019.
//  Copyright © 2019 Daniel Pecher. All rights reserved.
//

import UIKit

class DottedView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(named: "DottedLine")!.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [2, 2]

        let path = CGMutablePath()
        path.addLines(between: [
            CGPoint(x: bounds.minX, y: bounds.height / 2),
            CGPoint(x: bounds.maxX, y: bounds.height / 2),
        ])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}
