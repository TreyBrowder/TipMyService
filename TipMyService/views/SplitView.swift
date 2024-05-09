//
//  SplitView.swift
//  TipMyService
//
//  Created by Trey Browder on 5/8/24.
//

import UIKit

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
        
        return btn
    }()
    
    private lazy var increaseBtn: UIButton = {
        let btn = buildBtn(
            text: "+",
            corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        return btn
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = LabelCreater.build(
            text: "1",
            font: ThemeFont.bold(ofSize: 20),
            backgroundColor: .white)
        
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

    init(){
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func buildBtn(text: String, corners: CACornerMask) -> UIButton {
        let btn = UIButton()
        btn.setTitle(text, for: .normal)
        btn.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        btn.addRoundedCorners(corners: corners, radius: 8.0)
        btn.backgroundColor = ThemeColor.primary
        
        return btn
    }
}
