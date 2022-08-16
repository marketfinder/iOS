//
//  BaseLabel.swift
//  MarketFinder
//
//  Created by User on 2022/06/21.
//

import UIKit

class BaseLabel: UILabel {
    
    init(title: String? = nil) {
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
        self.textAlignment = .center
        
        if let title:String = title {
            self.text = title.localized
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
