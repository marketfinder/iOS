//
//  ViewModelType.swift
//  MarketFinder
//
//  Created by User on 2022/08/17.
//

import Foundation
import RxSwift

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    var disposeBag:DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
