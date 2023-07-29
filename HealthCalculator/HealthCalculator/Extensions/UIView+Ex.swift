//
//  UIView+Ex.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 01.07.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
 }
