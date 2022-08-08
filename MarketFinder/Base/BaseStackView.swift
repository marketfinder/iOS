//
//  BaseStackView.swift
//  MarketFinder
//
//  Created by User on 2022/08/04.
//

import UIKit

class BaseStackView: UIStackView {
    
    init(axis: NSLayoutConstraint.Axis = .vertical) {
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
