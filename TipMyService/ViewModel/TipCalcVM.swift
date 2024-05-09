//
//  TipCalcVM.swift
//  TipMyService
//
//  Created by Trey Browder on 5/9/24.
//

import Foundation
import Combine

class TipCalcVM {
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPushier: AnyPublisher<Result, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func transform(input: Input) -> Output {
        
        input.tipPublisher.sink { tip in
            print("tip: \(tip)")
        }.store(in: &cancellables)
        
        let result = Result(amountPerPersom: 500, totalBill: 1000, totalTip: 50.0)
        
        return Output(updateViewPushier: Just(result).eraseToAnyPublisher())
    }
}
