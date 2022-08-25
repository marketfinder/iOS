//
//  MartInfoView.swift
//  MarketFinder
//
//  Created by User on 2022/08/19.
//

import Foundation
import RxSwift
import RxCocoa

class MartInfoView: BaseView {
    
    // MARK: - Properties
    private let martBusinessStatusLabel:BaseLabel = {
        let label:BaseLabel = BaseLabel(title: "영업종료")
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        return label
    }()
    
    private let martNameLabel:BaseLabel = {
        let label:BaseLabel = BaseLabel(title: "롯데마트 월드컵경기장점")
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        
        return label
    }()
    
    private let martAddressLabel:BaseLabel = {
        let label:BaseLabel = BaseLabel(title: "서울시 구로구 구로1동 234-23번지 불몬몬스터빌딩 지하1층")
        label.textAlignment = .left
        
        return label
    }()
    
    private let callButton:BaseButton = BaseButton(fontIcon: .phone, style: .solid, textColor: UIColor(white: 0, alpha: 0.5), fontSize: 25)
    
    private let gotoNavigationButton:BaseButton = BaseButton(title: "길 찾기")
    
    private let disposeBag:DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    init() {
        super.init()
        
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true

        self.martBusinessStatusLabel.backgroundColor = UIColor(displayP3Red: 59/255, green: 162/255, blue: 52/255, alpha: 1)
        self.martBusinessStatusLabel.layer.cornerRadius = 5
        self.martBusinessStatusLabel.layer.masksToBounds = true

        self.addSubviews(views: [
            self.martBusinessStatusLabel,
            self.martNameLabel,
            self.martAddressLabel,
            self.callButton,
            self.gotoNavigationButton
        ])
        
        self.bindUI()
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.martBusinessStatusLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            self.martBusinessStatusLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            self.martBusinessStatusLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 75),
            self.martBusinessStatusLabel.heightAnchor.constraint(equalToConstant: 30),
            
            self.martNameLabel.topAnchor.constraint(equalTo: self.martBusinessStatusLabel.topAnchor),
            self.martNameLabel.leftAnchor.constraint(equalTo: self.martBusinessStatusLabel.rightAnchor, constant: 10),
            self.martNameLabel.rightAnchor.constraint(equalTo: self.callButton.leftAnchor, constant: -10),
            self.martNameLabel.heightAnchor.constraint(equalTo: self.martBusinessStatusLabel.heightAnchor),
            
            self.martAddressLabel.topAnchor.constraint(equalTo: self.martBusinessStatusLabel.bottomAnchor, constant: 10),
            self.martAddressLabel.leftAnchor.constraint(equalTo: self.martBusinessStatusLabel.leftAnchor),
            self.martAddressLabel.rightAnchor.constraint(equalTo: self.callButton.leftAnchor, constant: -10),
            self.martAddressLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            self.callButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.callButton.widthAnchor.constraint(equalToConstant: 50),
            self.callButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            self.callButton.bottomAnchor.constraint(equalTo: self.martAddressLabel.bottomAnchor),
            
            self.gotoNavigationButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            self.gotoNavigationButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            self.gotoNavigationButton.heightAnchor.constraint(equalToConstant: 45),
            self.gotoNavigationButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }
    
    override func bindUI() {
        self.gotoNavigationButton.rx.tap
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { _ in
                guard let url:URL = URL(string: "nmap://navigation?dlat=37.5209436&dlng=127.1230074&dname=%EC%98%AC%EB%A6%BC%ED%94%BD%EA%B3%B5%EC%9B%90&appname=com.sky.MarketFinder") else { return }

                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    let appStoreURL:URL = URL(string: "http://itunes.apple.com/app/id311867728?mt=8")!
                    UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                }
            }).disposed(by: self.disposeBag)
        
        self.callButton.rx.tap
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { _ in
                guard let url:URL = URL(string: "tel://\("01033268141")") else { return }
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }).disposed(by: self.disposeBag)
    }
}
