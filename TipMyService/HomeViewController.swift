//
//  ViewController.swift
//  TipMyService
//
//  Created by Trey Browder on 5/8/24.
//

import UIKit
import SnapKit
import Combine

class HomeViewController: UIViewController {
    
    private let headerView = HeaderView()
    private let resultView = ResultView()
    private let billView = BillView()
    private let tipInputView = TipInputView()
    private let splitView = SplitView()
    
    private let vm = TipCalcVM()
    private var cancelables = Set<AnyCancellable>()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
    }
    
    private func bind(){
        
        let input = TipCalcVM.Input(
            billPublisher: billView.billValuePublisher,
            tipPublisher: tipInputView.valuePublisher,
            splitPublisher: splitView.valuePublisher)
        
        let output = vm.transform(input: input)
        
        output.updateViewPushier.sink { [unowned self] result in
            resultView.configure(res: result)
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


