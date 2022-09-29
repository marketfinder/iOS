//
//  MartFilterViewModel.swift
//  MarketFinder
//
//  Created by User on 2022/08/17.
//

import Foundation
import RxSwift
import RxCocoa

class MartFilterViewModel: ViewModelType {

    var disposeBag: DisposeBag = DisposeBag()
    
    struct Input {
        let tapSaveFilter = PublishSubject<Void>()
    }
    
    struct Output {
//        let saveFilter: Driver<Void>
//        let error: Driver<Error>
    }
    
    private let selectMarkets:BehaviorRelay<[Mart]> = BehaviorRelay<[Mart]>(value: [])
    
    func transform(input: Input) -> Output {
//        input.saveFilterTrigger.bind(to: selectMarkets)
        return Output()
    }
}
