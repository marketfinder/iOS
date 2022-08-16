//
//  NoticeView.swift
//  MarketFinder
//
//  Created by User on 2022/08/16.
//

import UIKit
import RxSwift
import RxCocoa

class NoticeView: BaseView {
    
    // MARK: - Properties
    private let backView:BaseView = BaseView()
    
    private let noticeTypeLabel:BaseLabel = BaseLabel()
    
    private let titleLabel:BaseLabel = BaseLabel()
    
    private let dateLabel:BaseLabel = BaseLabel()
    
    private let disposeBag:DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override init(color: UIColor? = .white) {
        super.init()
        
        self.noticeTypeLabel.textAlignment = .left
        self.titleLabel.textAlignment = .left
        self.dateLabel.textAlignment = .right
        
        self.addSubviews(views: [
            self.backView
        ])
        
        self.backView.addSubviews(views: [
            self.noticeTypeLabel,
            self.dateLabel,
            self.titleLabel
        ])
        
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    func setNotice(notice:Notice) -> Void {
        let ob = Observable.of(notice).share()
        
        ob.map { $0.title }.bind(to: self.titleLabel.rx.text).disposed(by: self.disposeBag)
        
        ob.map { $0.date }.bind(to: self.dateLabel.rx.text).disposed(by: self.disposeBag)
        
        ob.map { String($0.type) }.bind(to: self.noticeTypeLabel.rx.text).disposed(by: self.disposeBag)
    }
    
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.backView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            self.backView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            self.backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            self.noticeTypeLabel.topAnchor.constraint(equalTo: self.backView.topAnchor),
            self.noticeTypeLabel.leftAnchor.constraint(equalTo: self.backView.leftAnchor),
            self.noticeTypeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
            self.noticeTypeLabel.heightAnchor.constraint(equalToConstant: 25),
            
            self.dateLabel.topAnchor.constraint(equalTo: self.backView.topAnchor),
            self.dateLabel.rightAnchor.constraint(equalTo: self.backView.rightAnchor),
            self.dateLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
            self.dateLabel.heightAnchor.constraint(equalToConstant: 25),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.noticeTypeLabel.bottomAnchor),
            self.titleLabel.leftAnchor.constraint(equalTo: self.backView.leftAnchor),
            self.titleLabel.rightAnchor.constraint(equalTo: self.backView.rightAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor)
        ])
    }
    
}
