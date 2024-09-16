//
//  UIView+Skeleton.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 14/09/24.
//

import UIKit

extension UIView {
    func showSkeleton() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [
            UIColor.lightGray.cgColor,
            UIColor.white.cgColor,
            UIColor.lightGray.cgColor
        ]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.removeAnimation(forKey: "skeletonAnimation")
        self.layer.addSublayer(gradient)

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.5, 1.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 1.5
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: "skeletonAnimation")
    }

    func hideSkeleton() {
        self.layer.sublayers?.forEach {
            if $0 is CAGradientLayer {
                $0.removeFromSuperlayer()
            }
        }
    }
}
