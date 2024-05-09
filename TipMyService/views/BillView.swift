//
//  BillViewController.swift
//  TipMyService
//
//  Created by Trey Browder on 5/8/24.
//

import UIKit

class BillView: UIView {

    private let inputHeaderView: LabelHeaderView = {
        let view = LabelHeaderView()
        view.configure(topText: "Enter", bottomText: "Your bill")
        return view
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 8.0)
        return view
    }()
    
    private let currencyLabel: UILabel = {
       let label = LabelCreater.build(
            text: "$",
            font: ThemeFont.bold(ofSize: 20))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var textFieldView: UITextField = {
       let field = UITextField()
        field.borderStyle = .none
        field.font = ThemeFont.bold(ofSize: 24)
        field.keyboardType = .decimalPad
        field.setContentHuggingPriority(.defaultLow, for: .horizontal)
        field.tintColor = ThemeColor.text
        field.textColor = ThemeColor.text
        
        //add toolbar - this only works because its initallized a "lazy var" and NOT "let"
        //could also be refactored to its own method
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        //add done button
        let doneBtn = UIBarButtonItem(title: "Done",
                                      style: .plain,
                                      target: self,
                                      action: #selector(didTapDoneBtn))
        toolbar.items = [
            UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                    target: nil,
                    action: nil),
            doneBtn
        ]
        toolbar.isUserInteractionEnabled = true
        field.inputAccessoryView = toolbar
        return field
    }()
    
    init(){
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        [inputHeaderView, textFieldContainerView].forEach(addSubview(_:))
        
        
        inputHeaderView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(textFieldContainerView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
        }
        
        textFieldContainerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        textFieldContainerView.addSubview(currencyLabel)
        textFieldContainerView.addSubview(textFieldView)
        
        currencyLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
        }
        
        textFieldView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(currencyLabel.snp.trailing).offset(16)
            make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
        }
        
    }
    
    @objc private func didTapDoneBtn(){
        textFieldView.endEditing(true)
    }
    
}

