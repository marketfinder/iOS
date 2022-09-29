//
//  ContactUsController.swift
//  MarketFinder
//
//  Created by User on 2022/08/17.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ContactUsController: BaseController {
    
    // MARK: - Properties
    private let titleLabel:BaseLabel = BaseLabel(title: "제목")
    
    private let titleTextField:BaseTextField = BaseTextField(placeholder: "제목을 입력하세요.")
    
    private let contactUsTypeLabel:BaseLabel = BaseLabel(title: "제목")

    private let contactUsTypePickerView:UIPickerView = UIPickerView()
    
    private let emailLabel:BaseLabel = BaseLabel(title: "제목")

    private let emailTextField:BaseTextField = {
        let emailTextField:BaseTextField = BaseTextField(placeholder: "제목을 입력하세요.")
        emailTextField.keyboardType = .emailAddress
        
        return emailTextField
    }()

    private let contentTitleLabel:BaseLabel = BaseLabel(title: "제목")
    
    private let contentTextView:BaseTextView = BaseTextView()
    
    private let sendButton:BaseButton = BaseButton()
    
    private let viewModel:ContactUsViewModel = ContactUsViewModel()
    
    private let items:BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: ["버그 및 오류 문의", "개선사항 문의", "기타"])
    
    private let backButttonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage.fontAwesomeIcon(name: .arrowLeft, style: .solid, textColor: .black, size: CGSize(width: 25, height: 25)), style: .plain, target: nil, action: nil)
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.view.addSubviews(views: [
            self.titleLabel,
            self.titleTextField,
            self.contactUsTypeLabel,
            self.contactUsTypePickerView,
            self.emailLabel,
            self.emailTextField,
            self.contentTitleLabel,
            self.contentTextView,
            self.sendButton
        ])
        
        self.contactUsTypePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.items.bind(to: self.contactUsTypePickerView.rx.itemTitles) { (row:Int, item:String) in
            return item
        }.disposed(by: self.disposeBag)
        
        self.setupLayouts()
        self.bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func bindUI() {
        let input:ContactUsViewModel.Input = ContactUsViewModel.Input(
            title: self.titleTextField.rx.text.orEmpty.asDriver(),
//            contactUsType: self.contactUsTypePickerView.rx.modelSelected(String.self).asDriver(),
            email: self.emailTextField.rx.text.orEmpty.asDriver(),
            content: self.contentTextView.rx.text.orEmpty.asDriver(),
            tapBackButton: self.backButttonItem.rx.tap.asDriver()
        )

        let output:ContactUsViewModel.Output = viewModel.transform(input: input)

        output.enableSendButton
            .drive(self.sendButton.rx.isUserInteractionEnabled)
            .disposed(by: self.disposeBag)
        
        output.goToBack
            .drive(onNext: { _ in
                self.popViewController()
            }).disposed(by: self.disposeBag)
        
        self.sendButton.rx.tap
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { _ in
                print("OK")
            }).disposed(by: self.disposeBag)
    }
    
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
            self.titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5),
            self.titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5),
            self.titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            self.titleTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            self.titleTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5),
            self.titleTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5),
            self.titleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            self.contactUsTypeLabel.topAnchor.constraint(equalTo: self.titleTextField.bottomAnchor, constant: 5),
            self.contactUsTypeLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5),
            self.contactUsTypeLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5),
            self.contactUsTypeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),

            self.contactUsTypePickerView.topAnchor.constraint(equalTo: self.contactUsTypeLabel.bottomAnchor, constant: 5),
            self.contactUsTypePickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5),
            self.contactUsTypePickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5),
            self.contactUsTypePickerView.heightAnchor.constraint(equalToConstant: 50),

            self.emailLabel.topAnchor.constraint(equalTo: self.contactUsTypePickerView.bottomAnchor, constant: 5),
            self.emailLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5),
            self.emailLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5),
            self.emailLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),

            self.emailTextField.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 5),
            self.emailTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5),
            self.emailTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 50),

            self.contentTitleLabel.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 5),
            self.contentTitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5),
            self.contentTitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5),
            self.contentTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),

            self.contentTextView.topAnchor.constraint(equalTo: self.contentTitleLabel.bottomAnchor, constant: 5),
            self.contentTextView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5),
            self.contentTextView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5),
            self.contentTextView.bottomAnchor.constraint(equalTo: self.sendButton.topAnchor, constant: -5),

            self.sendButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            self.sendButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5),
            self.sendButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5),
            self.sendButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}
