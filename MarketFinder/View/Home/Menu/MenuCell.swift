//
//  MenuCell.swift
//  MarketFinder
//
//  Created by User on 2022/08/16.
//

import UIKit
import RxSwift

class MenuCell: BaseTableViewCell {
    
    // MARK: - Properties
    var title:String? {
        didSet {
            guard let title:String = title else { return }
            
            Observable.of(title).bind(to: self.menuLabel.rx.text)
                .disposed(by: self.disposeBag)
        }
    }
    
    private let menuLabel:BaseLabel = BaseLabel(title: "")
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(self.menuLabel)
        
        self.bind()
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func bind() {
    }
    
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.menuLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.menuLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.menuLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.menuLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
