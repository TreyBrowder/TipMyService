//
//  ResultViewController.swift
//  TipMyService
//
//  Created by Trey Browder on 5/8/24.
//

import UIKit

class ResultView: UIView {
    
    private let resultHeaderLabel: UILabel = {
        LabelCreater.build(
            text: "Total per person",
            font: ThemeFont.demiBold(ofSize: 20),
            textAlignment: .center)
    }()
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [
                .font: ThemeFont.bold(ofSize: 48)
            ])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 24)
        ], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private let HorizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    private lazy var hStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            AmountView(),
            UIView(),
            AmountView()
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var vStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            resultHeaderLabel,
            totalLabel,
            HorizontalLineView,
            buildSpacer(height: 0),
            hStack
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    init(){
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        backgroundColor = .white
        addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.top.equalTo(snp_topMargin).offset(24)
            make.leading.equalTo(snp_leadingMargin).offset(24)
            make.trailing.equalTo(snp_trailingMargin).offset(-24)
            make.bottom.equalTo(snp_bottomMargin).offset(-24)
        }
        HorizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        addShadow(
            offset: CGSize(width: 0, height: 3),
            color: .black,
            radius: 12.0,
            opacity: 0.1)
    }
    
    private func buildSpacer(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return view
    }
}

class AmountView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        backgroundColor = .red
    }
}