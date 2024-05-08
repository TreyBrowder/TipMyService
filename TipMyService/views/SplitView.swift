//
//  SplitView.swift
//  TipMyService
//
//  Created by Trey Browder on 5/8/24.
//

import UIKit

class SplitView: UIView {

    init(){
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        backgroundColor = .systemMint
    }
}
