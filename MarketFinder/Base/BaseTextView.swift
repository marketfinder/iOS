//
//  BaseTextView.swift
//  MarketFinder
//
//  Created by User on 2022/08/16.
//

import UIKit

class BaseTextView: UITextView {

    init() {
        super.init(frame: .zero, textContainer: nil)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
