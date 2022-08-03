//
//  BaseLabel.swift
//  MarketFinder
//
//  Created by User on 2022/06/21.
//

import UIKit

class BaseLabel: UILabel {
    
    init(title: String) {
        super.init(frame: .zero)

        self.text = title
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
