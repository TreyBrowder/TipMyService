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
        let headerViewTapPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let updateViewPushier: AnyPublisher<Result, Never>
        let resetTipCalcPublisher: AnyPublisher<Void, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let audioPlayerService: AudioPlayerService
    
    init(audioPlayerService: AudioPlayerService = AudioPlayerClass()) {
        self.audioPlayerService = audioPlayerService
    }
    
    func transform(input: Input) -> Output {
        
        let updateViewPublisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher).flatMap { [unowned self] (bill, tip, split) in
                let totalTip = getTipAmount(bill: bill, tip: tip)
                let totalBill = bill + totalTip
                let totalPerPerson = totalBill / Double(split)
                let result = Result(
                    amountPerPersom: totalPerPerson,
                    totalBill: totalBill,
                    totalTip: totalTip)
                
                return Just(result)
            }.eraseToAnyPublisher()
        
        let resetTipcalcPublisher = input
            .headerViewTapPublisher
            .handleEvents(receiveOutput: { [unowned self] in
            audioPlayerService.playSound()
        }).flatMap {
            return Just($0)
        }.eraseToAnyPublisher()
        
        return Output(
            updateViewPushier: updateViewPublisher,
            resetTipCalcPublisher: resetTipcalcPublisher)
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double{
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(let value):
            return Double(value)
        }
    }
}
