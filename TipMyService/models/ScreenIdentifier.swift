//
//  ScreenIdentifier.swift
//  TipMyService
//
//  Created by Trey Browder on 5/10/24.
//

import Foundation

enum ScreenIdentifier {
    
    enum HeaderView: String {
        case headerView
    }
    
    enum ResultView: String {
        case totalAmountPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    enum BillView: String {
        case textField
    }
    
    enum TipInputView: String {
        case tenBtn
        case fifteenBtn
        case twentyBtn
        case customBtn
        case customAlertTxtField
    }
    
    enum SplitView: String {
        case decrementBtn
        case increaseBtn
        case quantityLabel
    }
}
