//
//  MartFilterController.swift
//  MarketFinder
//
//  Created by User on 2022/08/12.
//

import UIKit

struct Mart {
    let isSelected:Bool? = false
    let code:Int
    let name:String
}

class MartFilterController: BaseController {
    
    // MARK: - Properties
    private let titleLabel:BaseLabel = BaseLabel(title: "")
    
    private let martTableview:BaseTableView = BaseTableView(cellClass: MartFilterCell.self, forCellReuseIdentifier: "martFilterCell")
    
//    private let marts:

    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.view.addSubviews(views: [
            self.titleLabel,
            self.martTableview
        ])
        
        self.setupLayouts()
        self.bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func bindUI() {
        
    }
    
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            self.titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),

            self.martTableview.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15),
            self.martTableview.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.martTableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.martTableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
