//
//  Tip.swift
//  TipMyService
//
//  Created by Trey Browder on 5/9/24.
//

import UIKit

enum Tip {
    case none
    case tenPercent
    case fifteenPercent
    case twentyPercent
    case custon(input: Int)
    
    var stringVal: String {
        switch self {
        case .none:
            return ""
        case .tenPercent:
            return "10%"
        case .fifteenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case .custon(let input):
            return String(input)
        }
    }
}
