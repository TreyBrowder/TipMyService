//
//  SplitView.swift
//  TipMyService
//
//  Created by Trey Browder on 5/8/24.
//

import UIKit
import Combine
import CombineCocoa

class SplitView: UIView {
    
    private let splitLabelHeader: LabelHeaderView = {
        let view = LabelHeaderView()
        view.configure(topText: "Split", bottomText: "the total")
        return view
    }()
    
    private lazy var decreaseBtn: UIButton = {
        let btn = buildBtn(
            text: "-",
            corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        
        btn.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1 )
        }.assign(to: \.value, on: splitSubject)
            .store(in: &cancellables)
        
        btn.accessibilityIdentifier = ScreenIdentifier
            .SplitView
            .decrementBtn
            .rawValue
        
        return btn
    }()
    
    private lazy var increaseBtn: UIButton = {
        let btn = buildBtn(
            text: "+",
            corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        
        btn.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value + 1 )
        }.assign(to: \.value, on: splitSubject)
            .store(in: &cancellables)
        
        btn.accessibilityIdentifier = ScreenIdentifier
            .SplitView
            .increaseBtn
            .rawValue
        
        return btn
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = LabelCreater.build(
            text: "1",
            font: ThemeFont.bold(ofSize: 20),
            backgroundColor: .white)
        
        label.accessibilityIdentifier = ScreenIdentifier
            .SplitView
            .quantityLabel
            .rawValue

        return label
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            decreaseBtn,
            quantityLabel,
            increaseBtn
        ])
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    private let splitSubject: CurrentValueSubject<Int, Never> = .init(1)
    var valuePublisher: AnyPublisher<Int, Never> {
        return splitSubject.removeDuplicates().eraseToAnyPublisher()
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
    
    func reset(){
        splitSubject.send(1)
    }
    
    private func layout(){
        [splitLabelHeader, hStackView].forEach(addSubview(_:))
        
        hStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        [increaseBtn, decreaseBtn].forEach { btn in
            btn.snp.makeConstraints { make in
                make.width.equalTo(btn.snp.height)
            }
        }
        
        splitLabelHeader.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(hStackView.snp.centerY)
            make.trailing.equalTo(hStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
    }
    
    private func observe(){
        splitSubject.sink { [unowned self] num in
            quantityLabel.text = num.stringValue
        }.store(in: &cancellables)
    }
    
    private func buildBtn(text: String, corners: CACornerMask) -> UIButton {
        let btn = UIButton()
        btn.setTitle(text, for: .normal)
        btn.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        btn.addRoundedCorners(corners: corners, radius: 8.0)
        btn.backgroundColor = ThemeColor.primary
        
        return btn
    }
}
