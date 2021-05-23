//
//  UIButton+gradation.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/21.
//

import Foundation
import UIKit

extension UIView {
    func setGradient(color1: UIColor, color2: UIColor) {
        let gradient = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    func setViewShadow(backView: UIView) {
//        backView.layer.masksToBounds = true
//        backView.layer.cornerRadius = 10
//        backView.layer.borderWidth = 1
        
//        backView.layer.borderColor = UIColor.red.cgColor
//        layer.shadowColor = UIColor.gray.cgColor
        layer.masksToBounds = false
        
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: -2, height: 2)
        layer.shadowRadius = 3
    }
}
