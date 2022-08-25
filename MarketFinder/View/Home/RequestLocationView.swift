//
//  RequestLocationView.swift
//  MarketFinder
//
//  Created by User on 2022/08/24.
//

import Foundation
import FontAwesome_swift
import UIKit

class RequestLocationView: BaseView {
    
    // MARK: - Properties
    private let iconLabel:BaseLabel = {
        let label:BaseLabel = BaseLabel(title: String.fontAwesomeIcon(name: .compass))
        label.font = UIFont.fontAwesome(ofSize: 35, style: .solid)
        
        return label
    }()

    private let titleLabel:BaseLabel = {
        let label:BaseLabel = BaseLabel(title: "위치서비스 변경")
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        return label
    }()
    
    private let contentLabel:BaseLabel = {
        let label:BaseLabel = BaseLabel(title: "마켓파인더는 근처 마트를 찾기 위해 사용자의 정확한 위치가 필요합니다")
        label.textAlignment = .left
        
        return label
    }()

    private let gotoLocationSettingButton:BaseButton = BaseButton(title: "정확한 위치 켜기")
    
    private let inputAddressButton:BaseButton = BaseButton(title: "다른 위치 입력")

    // MARK: - Life Cycle
    init() {
        super.init()

        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true

        self.addSubviews(views: [
            self.iconLabel,
            self.titleLabel,
            self.contentLabel,
            self.gotoLocationSettingButton,
            self.inputAddressButton
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
            self.iconLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            self.iconLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            self.iconLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30),
            self.iconLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.iconLabel.topAnchor),
            self.titleLabel.leftAnchor.constraint(equalTo: self.iconLabel.rightAnchor, constant: 10),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            self.titleLabel.heightAnchor.constraint(equalTo: self.iconLabel.heightAnchor),
            
            self.contentLabel.topAnchor.constraint(equalTo: self.iconLabel.bottomAnchor, constant: 10),
            self.contentLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            self.contentLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            self.contentLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),

            self.gotoLocationSettingButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            self.gotoLocationSettingButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            self.gotoLocationSettingButton.heightAnchor.constraint(equalTo: self.inputAddressButton.heightAnchor),
            self.gotoLocationSettingButton.bottomAnchor.constraint(equalTo: self.inputAddressButton.topAnchor, constant: -10),
            
            self.inputAddressButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            self.inputAddressButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            self.inputAddressButton.heightAnchor.constraint(equalToConstant: 45),
            self.inputAddressButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }
    
    override func bindUI() {
        
    }
}
