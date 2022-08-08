//
//  RequireUpdateController.swift
//  MarketFinder
//
//  Created by User on 2022/08/04.
//

import UIKit
import RxSwift

class RequireUpdateController: AppUpdateController {
    
    // MARK: - Properties
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
        
        self.view.addSubviews(views: [
            self.updateButton
        ])
        
        self.setInfoView(appUpdate: .require)
        
        self.bindUI()

        self.setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Function
    override func bindUI() {
        self.updateButton.rx.tap
            .asDriver()
            .drive(onNext: { _ in
                if let url:URL = URL(string: String.appUrl) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            })
            .disposed(by: self.disposeBag)

    }
    
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.updateButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -35),
            self.updateButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15),
            self.updateButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15),
            self.updateButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
