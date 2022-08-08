//
//  UIStackView.swift
//  MarketFinder
//
//  Created by User on 2022/08/04.
//

import UIKit

extension UIStackView {
    
    // MARK: - Extension Function
    func addArrangedSubviews(views: [UIView]) -> Void {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
