//
//  Double+Extention.swift
//  TipMyService
//
//  Created by Trey Browder on 5/9/24.
//

import Foundation

extension Double {
    var currencyFormatted: String {
        var isWholeNum: Bool {
            isZero ? true : !isNormal ? false: self == rounded()
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = isWholeNum ? 0 : 2
        return formatter.string(for: self) ?? ""
    }
}
