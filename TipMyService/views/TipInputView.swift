//
//  TipInputView.swift
//  TipMyService
//
//  Created by Trey Browder on 5/8/24.
//

import UIKit

class TipInputView: UIView {
    
    private let tipHeaderView: LabelHeaderView = {
        let view = LabelHeaderView()
        view.configure(topText: "Choose", bottomText: "Your tip")
        return view
    }()
    
    private lazy var tenPercentTipBtn: UIButton = {
        let btn = buildTipBtn(tip: .tenPercent)
        return btn
    }()
    
    private lazy var fifteenPercentTipBtn: UIButton = {
        let btn = buildTipBtn(tip: .fifteenPercent)
        return btn
    }()
    
    private lazy var twentyPercentTipBtn: UIButton = {
        let btn = buildTipBtn(tip: .twentyPercent)
        return btn
    }()
    
    private lazy var customTipBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Custom Tip", for: .normal)
        btn.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        btn.backgroundColor = ThemeColor.primary
        btn.addCornerRadius(radius: 8.0)
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
    
    init(){
        super.init(frame: .zero)
        layout()
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

