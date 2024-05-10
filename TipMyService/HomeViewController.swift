//
//  ViewController.swift
//  TipMyService
//
//  Created by Trey Browder on 5/8/24.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class HomeViewController: UIViewController {
    
    private let headerView = HeaderView()
    private let resultView = ResultView()
    private let billView = BillView()
    private let tipInputView = TipInputView()
    private let splitView = SplitView()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerView,
            resultView,
            billView,
            tipInputView,
            splitView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
    
    
    private let label: UILabel = {
    let labelVar = UILabel()
    labelVar.text = "Home"
    labelVar.textColor = .green
    labelVar.font = UIFont.systemFont(ofSize: 20)
    return labelVar
    }()
    
    private let vm = TipCalcVM()
    private var cancelables = Set<AnyCancellable>()
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(tapGesture)
         return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    private lazy var headerViewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.numberOfTapsRequired = 2
        headerView.addGestureRecognizer(tapGesture)
         return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
        observe()
    }
    
    private func observe() {
        viewTapPublisher.sink { [unowned self] () in
            view.endEditing(true)
        }.store(in: &cancelables)
        
        headerViewTapPublisher.sink { () in
            print("HeaderView TipCalc FIRE")
        }.store(in: &cancelables)
    }
    
    private func bind(){
        
        let input = TipCalcVM.Input(
            billPublisher: billView.billValuePublisher,
            tipPublisher: tipInputView.valuePublisher,
            splitPublisher: splitView.valuePublisher,
            headerViewTapPublisher: headerViewTapPublisher)
    
        
        let output = vm.transform(input: input)
        
        output.updateViewPushier.sink { [unowned self] result in
            resultView.configure(res: result)
        }.store(in: &cancelables)
        
        output.resetTipCalcPublisher.sink { [unowned self] _ in
            billView.reset()
            tipInputView.reset()
            splitView.reset()
            
            //add animation to the reset
            UIView.animate(
                withDuration: 0.1,
                delay: 0,
                usingSpringWithDamping: 5.0,
                initialSpringVelocity: 0.5,
                options: .curveEaseInOut) {
                    self.headerView.transform = .init(scaleX: 1.5, y: 1.5)
                } completion: { _ in
                    UIView.animate(withDuration: 0.1) {
                        self.headerView.transform = .identity
                    }
                }

        }.store(in: &cancelables)
    }

    private func layout() {
        view.backgroundColor = ThemeColor.bg
        //add vertical stack to home view
        view.addSubview(verticalStackView)
        
        //set heights for each view controller
        headerView.snp.makeConstraints { maker in
            maker.height.equalTo(48)
        }
        
        resultView.snp.makeConstraints { maker in
            maker.height.equalTo(240)
        }
        
        billView.snp.makeConstraints { maker in
            maker.height.equalTo(48)
        }
        
        tipInputView.snp.makeConstraints { maker in
            maker.height.equalTo(152)
        }
        
        splitView.snp.makeConstraints { maker in
            maker.height.equalTo(56)
        }
        //set up constraints usings snapkit
        verticalStackView.snp.makeConstraints { maker in
            maker.leading.equalTo(view.snp_leadingMargin).offset(16)
            maker.trailing.equalTo(view.snp_trailingMargin).offset(-16)
            maker.top.equalTo(view.snp_topMargin).offset(16)
            maker.bottom.equalTo(view.snp_bottomMargin).offset(-16)
        }
        
    }

}


