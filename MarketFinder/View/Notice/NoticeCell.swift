//
//  NoticeCell.swift
//  MarketFinder
//
//  Created by User on 2022/08/16.
//

import UIKit
import RxSwift
import RxCocoa

struct Notice {
    let type: Int
    let date: String
    let title: String
}

class NoticeCell: BaseTableViewCell {
    
    // MARK: - Properties
    var notice:Notice? {
        didSet {
            guard let notice:Notice = notice else { return }
            
            self.noticeView.setNotice(notice: notice)
        }
    }
    
    private let noticeView:NoticeView = NoticeView()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubviews(views: [
            self.noticeView
        ])
        
        self.setupLayouts()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func bind() {
    }
    
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.noticeView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.noticeView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15),
            self.noticeView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15),
            self.noticeView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
        ])
    }
}
