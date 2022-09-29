//
//  MartFilterTableViewCell.swift
//  MarketFinder
//
//  Created by User on 2022/08/12.
//

import UIKit
import FontAwesome_swift

class MartFilterCell: BaseTableViewCell {
    
    // MARK: - Properties
    private let checkButton:BaseButton = BaseButton(fontIcon: .checkCircle, style: .solid, fontSize: 15)
    
    private let brandImageView:BaseImageView = BaseImageView()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubviews(views: [
            self.checkButton,
            self.brandImageView
        ])
        
        self.setupLayouts()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.checkButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.checkButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.checkButton.widthAnchor.constraint(equalToConstant: 35),
            self.checkButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            
            self.brandImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.brandImageView.leftAnchor.constraint(equalTo: self.checkButton.rightAnchor, constant: 10),
            self.brandImageView.widthAnchor.constraint(equalToConstant: 100),
            self.brandImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
        ])
    }
    
    override func bind() {
        
    }
}
