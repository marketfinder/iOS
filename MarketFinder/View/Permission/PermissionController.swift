//
//  PermissionController.swift
//  MarketFinder
//
//  Created by User on 2022/08/04.
//

import UIKit
import FontAwesome_swift

enum Permission: String {
    case location
    case push
    
    var icon:UIImage {
        var iconName:FontAwesome = .map
        
        switch self {
            case .location:
                iconName = .map
            default:
                iconName = .bell
        }
        
        return UIImage.fontAwesomeIcon(name: iconName, style: .solid, textColor: .gray, size: CGSize(width: 15, height: 15))
    }
    
    var content:String {
        var content:String = ""
        
        switch self {
            case .location:
                content = "Required"
            default:
                content = "Required"
        }
        
        return content.localized
    }
}

class PermissoinController: BaseController {
    
    // MARK: - Properties
    private let infoView:BaseView = BaseView()
    
    private let iconImage:BaseImageView = BaseImageView()

    private let contentLabel:BaseLabel = BaseLabel(title: "")
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.infoView.addSubviews(views: [
            self.iconImage,
            self.contentLabel
        ])
        
        self.view.addSubviews(views: [
            self.infoView
        ])
        
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    func setInfoView(permission: Permission) -> Void {
        self.iconImage.image = permission.icon
        self.contentLabel.text = permission.content
    }
    
    private func setupLayout() -> Void {
        NSLayoutConstraint.activate([
            self.infoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 25),
            self.infoView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25),
            self.infoView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25),
            self.infoView.heightAnchor.constraint(equalToConstant: 250),
            
            self.iconImage.topAnchor.constraint(equalTo: self.infoView.topAnchor),
            self.iconImage.centerXAnchor.constraint(equalTo: self.infoView.centerXAnchor),
            self.iconImage.heightAnchor.constraint(equalToConstant: 150),
            self.iconImage.widthAnchor.constraint(equalTo: self.iconImage.heightAnchor),

            self.contentLabel.rightAnchor.constraint(equalTo: self.infoView.rightAnchor),
            self.contentLabel.leftAnchor.constraint(equalTo: self.infoView.leftAnchor),
            self.contentLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            self.contentLabel.bottomAnchor.constraint(equalTo: self.infoView.bottomAnchor),
        ])
    }
}
