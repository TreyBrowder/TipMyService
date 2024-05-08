//
//  HeaderViewController.swift
//  TipMyService
//
//  Created by Trey Browder on 5/8/24.
//

import UIKit

class HeaderView: UIView {
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: .init(named: ""))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Tip PLEASE",
            attributes: [.font: ThemeFont.demiBold(ofSize: 16)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)],
                           range: NSMakeRange(4, 6))
        label.attributedText = text
        return label
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        
        
        return label
    }()
    
    private lazy var hStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
        
        ])
        
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .center
        return view
    }()
    
    init(){
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .green
    }

}
