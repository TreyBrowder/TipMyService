//
//  TipCalcScreen.swift
//  TipMyServiceUITests
//
//  Created by Trey Browder on 5/10/24.
//

import XCTest

class TipCalcScreen {
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication){
        self.app = app
    }
    
    var ttlAmountPerPersonValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalAmountPersonValueLabel.rawValue]
    }
    
    var ttlBillValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalBillValueLabel.rawValue]
    }
    
    var ttlTipValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalTipValueLabel.rawValue]
    }
    
}
