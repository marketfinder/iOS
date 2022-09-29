//
//  ContactUsViewModel.swift
//  MarketFinder
//
//  Created by User on 2022/08/17.
//

import Foundation
import RxSwift
import RxCocoa

class ContactUsViewModel: ViewModelType {
    
    struct Input {
        let title:Driver<String>
//        let contactUsType:Driver<String>
        let email:Driver<String>
        let content:Driver<String>
        let tapBackButton:Driver<Void>
    }
    
    struct Output {
        let enableSendButton:Driver<Bool>
        let goToBack:Driver<Void>
//        let errorMessage:Observable<String>
//        let goToMain:Observable<Void>
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private let isSending = BehaviorRelay<Bool>(value: false)
    
    func transform(input: Input) -> Output {
        let enableSendButtonOb:SharedSequence<DriverSharingStrategy, Bool> = Observable.combineLatest(input.title.asObservable(), input.content.asObservable(), input.email.asObservable())
            .map { self.isValidContent($0.0) && $0.1.count > 0 && self.isValidateEmail($0.2) ? true : false }
            .asDriver(onErrorJustReturn: false)
        
//        input.tapBackButton.flatMap {}
//        .asDriver()

        return Output(
            enableSendButton: enableSendButtonOb,
            goToBack: input.tapBackButton
        )
    }
    
    // Check title validation
    private func isValidContent(_ text: String) -> Bool {
        let textRegex:String = "[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9._\\s]{2,50}"

        let textPred:NSPredicate = NSPredicate(format: "SELF MATCHES %@", textRegex)

        return textPred.evaluate(with: text)
    }
    
    // Check email validation
    private func isValidateEmail(_ email: String) -> Bool {
        let emailRegex:String = "[a-zA-Z0-9._]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,64}"
        
        let emailPred:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPred.evaluate(with: email)
    }
}
