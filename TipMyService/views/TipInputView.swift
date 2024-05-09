//
//  TipInputView.swift
//  TipMyService
//
//  Created by Trey Browder on 5/8/24.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    
    private let tipHeaderView: LabelHeaderView = {
        let view = LabelHeaderView()
        view.configure(topText: "Choose", bottomText: "Your tip")
        return view
    }()
    
    private lazy var tenPercentTipBtn: UIButton = {
        let btn = buildTipBtn(tip: .tenPercent)
        btn.tapPublisher.flatMap({
            Just(Tip.tenPercent)
        }).assign(to: \.value , on: tipSubject)
            .store(in: &cancellables)
        return btn
    }()
    
    private lazy var fifteenPercentTipBtn: UIButton = {
        let btn = buildTipBtn(tip: .fifteenPercent)
        btn.tapPublisher.flatMap({
            Just(Tip.fifteenPercent)
        }).assign(to: \.value , on: tipSubject)
            .store(in: &cancellables)
        return btn
    }()
    
    private lazy var twentyPercentTipBtn: UIButton = {
        let btn = buildTipBtn(tip: .twentyPercent)
        btn.tapPublisher.flatMap({
            Just(Tip.twentyPercent)
        }).assign(to: \.value , on: tipSubject)
            .store(in: &cancellables)
        return btn
    }()
    
    private lazy var customTipBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Custom Tip", for: .normal)
        btn.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        btn.backgroundColor = ThemeColor.primary
        btn.addCornerRadius(radius: 8.0)
        btn.tapPublisher.sink { [weak self] _ in
            self?.handleCustomTipBtn()
        }.store(in: &cancellables)
        
        return btn
    }()
    
    
    private lazy var btnHStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tenPercentTipBtn,
            fifteenPercentTipBtn,
            twentyPercentTipBtn
        ])
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var btnVStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            btnHStack,
            customTipBtn
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let tipSubject: CurrentValueSubject<Tip, Never> = .init(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [tipHeaderView, btnVStack].forEach(addSubview(_:))
        
        btnVStack.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        tipHeaderView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(btnVStack.snp.leading).offset(-24)
            make.width.equalTo(68)
            make.centerY.equalTo(btnHStack.snp.centerY)
        }
    }
    
    private func handleCustomTipBtn() {
        let alertController: UIViewController = {
            let controller = UIAlertController(
                title: "Enter custom tip",
                message: nil,
                preferredStyle: .alert)
            controller.addTextField { txtField in
                txtField.placeholder = "Make it generous!"
                txtField.keyboardType = .numberPad
                txtField.autocorrectionType = .no
            }
            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .cancel)
            let okayAction = UIAlertAction(
                title: "Ok",
                style: .default) { [weak self] _ in
                    
                    guard let text = controller.textFields?.first?.text,
                          let value = Int(text) else { return}
                    self?.tipSubject.send(.custom(input: value))
                }
            [okayAction, cancelAction].forEach(controller.addAction(_:))
            return controller
        }()
        parentViewController?.present(alertController, animated: true)
    }
    
    private func observe() {
        tipSubject.sink { [unowned self] tip in
            resetView()
            switch tip {
            case .none:
                break
            case .tenPercent:
                tenPercentTipBtn.backgroundColor = ThemeColor.secondary
            case .fifteenPercent:
                fifteenPercentTipBtn.backgroundColor = ThemeColor.secondary
            case .twentyPercent:
                twentyPercentTipBtn.backgroundColor = ThemeColor.secondary
            case .custom(let value):
                customTipBtn.backgroundColor = ThemeColor.secondary
                let text = NSMutableAttributedString(
                    string: "$\(value)",
                    attributes: [
                        .font: ThemeFont.bold(ofSize: 20)
                    ])
                text.addAttributes([
                    .font: ThemeFont.bold(ofSize: 14)
                ], range: NSMakeRange(0, 1))
                customTipBtn.setAttributedTitle(text, for: .normal)
            }
        }.store(in: &cancellables)
    }
    
    private func resetView() {
        [tenPercentTipBtn,
        fifteenPercentTipBtn,
        twentyPercentTipBtn,
         customTipBtn].forEach {
            $0.backgroundColor = ThemeColor.primary
        }
        
        let text = NSMutableAttributedString(
            string: "Custom tip",
            attributes: [.font: ThemeFont.bold(ofSize: 20)])
        customTipBtn.setAttributedTitle(text, for: .normal)
    }
    
    private func buildTipBtn(tip: Tip) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = ThemeColor.primary
        btn.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(
            string: tip.stringVal,
            attributes: [
                .font: ThemeFont.bold(ofSize: 20),
                .foregroundColor: UIColor.white
            ]
        )
        text.addAttributes([
            .font: ThemeFont.demiBold(ofSize: 14)
        ], range: NSMakeRange(2, 1))
        btn.setAttributedTitle(text, for: .normal)
        return btn
    }

}

