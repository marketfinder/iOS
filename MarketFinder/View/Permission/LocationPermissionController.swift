//
//  LocationPermissionController.swift
//  MarketFinder
//
//  Created by User on 2022/08/08.
//

import UIKit
import RxCocoa
import RxSwift
import CoreLocation

class LocationPermissionController: PermissionController {
    
    // MARK: - Properties
    private let manager:CLLocationManager = CLLocationManager()
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.setInfoView(permission: .location)

        self.bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func bindUI() {
        self.requestPermissionButton.rx.tap
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] _ in
                self?.manager.requestLocation()
            }).disposed(by: self.disposeBag)
        
        self.manager.rx.didChangeAuthorizationStatus
            .asDriver(onErrorJustReturn: .notDetermined)
            .drive(onNext: { (status:CLAuthorizationStatus) in
                switch status {
                    case .authorizedAlways, .authorizedWhenInUse:
                        break
                    case .notDetermined:
                        break
                    default:
                        break
                }
            })
            .disposed(by: self.disposeBag)
    }
}
