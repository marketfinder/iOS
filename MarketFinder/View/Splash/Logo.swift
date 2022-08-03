//
//  Logo.swift
//  MarketFinder
//
//  Created by User on 2022/06/21.
//

import UIKit
import FontAwesome_swift

class Logo: BaseView {
    
    private let logoImage:BaseImageView = BaseImageView(image: .logo)
    
    private let titleLabel:BaseLabel = BaseLabel(title: "Market Finder")
    
    init() {
        super.init(color: .clear)
        
        self.addSubviews(views: [
            self.logoImage,
            self.titleLabel
        ])
        
        self.titleLabel.textAlignment = .center
        
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.logoImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.logoImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.logoImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.logoImage.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: 10),
            
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
