//
//  AppUpdateController.swift
//  MarketFinder
//
//  Created by User on 2022/06/22.
//

import Foundation
import RxSwift
import RxCocoa

enum AppUpdate {
    case optional, required
}

class AppUpdateController: BaseController {
    
    // MARK: - Properties
    private let backButton:BaseButton = BaseButton(fontIcon: .arrowLeft, style: .solid)

    private let iconImage:BaseImageView = BaseImageView(image: .logo)

    private let titleLabel:BaseLabel = BaseLabel(title: "")
    
    private let contentLabel:BaseLabel = BaseLabel(title: "")
    
    private let closeButton:BaseButton = BaseButton()
    
    private let updateButton:BaseButton = BaseButton()
    
    // MARK: - Life Cycle
    init(appUpdate: AppUpdate) {
        super.init()

        if appUpdate == .optional {
            
        } else {
            
        }
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
                if let url:URL = URL(string: "") {
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
}
