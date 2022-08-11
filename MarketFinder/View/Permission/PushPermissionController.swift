//
//  PushPermissionController.swift
//  MarketFinder
//
//  Created by User on 2022/08/08.
//

import UIKit
import RxCocoa
import RxSwift

class PushPermissionController: PermissionController {
    
    // MARK: - Properties
    private let pushPermissionOb:Observable<Bool> = Observable.create { (observer:AnyObserver<Bool>) in
        UNUserNotificationCenter.current().requestAuthorization(options: [
            .alert, .badge, .sound
        ]) { (isGrant:Bool, error:Error?) in
            if let error:Error = error {
                observer.onError(error)
            } else {
                observer.onNext(isGrant)
            }
            
            observer.onCompleted()
        }
        
        return Disposables.create()
    }
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.setInfoView(permission: .push)
        
        self.bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func bindUI() {
        self.requestPermissionButton.rx.tap
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMapFirst { self.pushPermissionOb }
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { (isGrant:Bool) in
                guard let appDelegate:UIApplicationDelegate = UIApplication.shared.delegate else { return }
                appDelegate.window??.rootViewController = BaseNavigationController(rootViewController: HomeController())
                appDelegate.window??.makeKeyAndVisible()
            }).disposed(by: self.disposeBag)
    }
}
