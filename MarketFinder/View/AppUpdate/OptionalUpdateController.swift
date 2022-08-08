//
//  OptionalUpdateController.swift
//  MarketFinder
//
//  Created by User on 2022/08/04.
//

import Foundation
import RxSwift
import RxCocoa

class OptionalUpdateController: AppUpdateController {
    
    // MARK: - Properties
    private let buttonStackView:BaseStackView = {
        let stackView:BaseStackView = BaseStackView(axis: .horizontal)
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let closeButton:BaseButton = {
        let button:BaseButton = BaseButton()
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "DefaultColor")?.cgColor
        button.setTitle("CloseButton", for: .normal)
        button.setTitleColor(UIColor(named: "DefaultColor"), for: .normal)
        
        return button
    }()
    
    private let updateButton:BaseButton = {
        let button:BaseButton = BaseButton()
        button.backgroundColor = UIColor(named: "DefaultColor")
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "DefaultColor")?.cgColor
        button.setTitle("AppUpdateButton", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.buttonStackView.addArrangedSubviews(views: [
            self.closeButton,
            self.updateButton
        ])
        
        self.view.addSubviews(views: [
            self.buttonStackView
        ])
        
        self.setInfoView(appUpdate: .optional)
        
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func bindUI() {
        self.updateButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: { _ in
                if let url:URL = URL(string: String.appUrl) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }).disposed(by: self.disposeBag)
        
        self.closeButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: { _ in
                let mainController = BaseController()
                self.pushViewController(mainController)
            }).disposed(by: self.disposeBag)
    }
    
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.buttonStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -35),
            self.buttonStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15),
            self.buttonStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15),
            self.buttonStackView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
