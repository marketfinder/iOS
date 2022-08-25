//
//  NotSupportView.swift
//  MarketFinder
//
//  Created by User on 2022/08/24.
//

import Foundation
import FontAwesome_swift
import UIKit

class NotSupportServiceView: BaseView {
    
    // MARK: - Properties
    private let iconLabel:BaseLabel = {
        let label:BaseLabel = BaseLabel(title: String.fontAwesomeIcon(name: .question))
        label.font = UIFont.fontAwesome(ofSize: 45, style: .solid)
        
        return label
    }()

    private let titleLabel:BaseLabel = BaseLabel(title: "이 지역에서는 마트찾기 기능이 제공되지 않습니다")

    private let inputAnotherAddressButton:BaseButton = BaseButton(title: "다른 위치 입력")

    // MARK: - Life Cycle
    init() {
        super.init()

        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true

        self.addSubviews(views: [
            self.iconLabel,
            self.titleLabel,
            self.inputAnotherAddressButton
        ])

        self.setupLayouts()
        self.bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.iconLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.iconLabel.widthAnchor.constraint(equalTo: self.iconLabel.heightAnchor),
            self.iconLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            self.iconLabel.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: -15),
            
            self.titleLabel.leftAnchor.constraint(equalTo: self.inputAnotherAddressButton.leftAnchor),
            self.titleLabel.rightAnchor.constraint(equalTo: self.inputAnotherAddressButton.rightAnchor),
            self.titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.inputAnotherAddressButton.topAnchor, constant: -10),

            self.inputAnotherAddressButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            self.inputAnotherAddressButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            self.inputAnotherAddressButton.heightAnchor.constraint(equalToConstant: 45),
            self.inputAnotherAddressButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }
    
    override func bindUI() {
        
    }
}
