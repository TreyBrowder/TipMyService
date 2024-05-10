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
    
// MARK: HeaderView
    
    var headerView: XCUIElement {
        return app.otherElements[
            ScreenIdentifier
                .HeaderView
                .headerView
                .rawValue
        ]
    }
    
    
// MARK: ResultsView
    
    var ttlAmountPerPersonValueLabel: XCUIElement {
        return app.staticTexts[
            ScreenIdentifier
                .ResultView
                .totalAmountPersonValueLabel
                .rawValue
        ]
    }
    
    var ttlBillValueLabel: XCUIElement {
        return app.staticTexts[
            ScreenIdentifier
                .ResultView
                .totalBillValueLabel
                .rawValue
        ]
    }
    
    var ttlTipValueLabel: XCUIElement {
        return app.staticTexts[
            ScreenIdentifier
                .ResultView
                .totalTipValueLabel
                .rawValue
        ]
    }
    
// MARK: BillView
    
    var billInputTxtField: XCUIElement {
        return app.otherElements[
            ScreenIdentifier
                .BillView
                .textField
                .rawValue
        ]
    }
    
// MARK: TipInputView
    
    var tenButton: XCUIElement {
        return app.buttons[
            ScreenIdentifier
                .TipInputView
                .tenBtn
                .rawValue
        ]
    }
    
    var fifteenButton: XCUIElement {
        return app.buttons[
            ScreenIdentifier
                .TipInputView
                .fifteenBtn
                .rawValue
        ]
    }
    
    var twentyButton: XCUIElement {
        return app.buttons[
            ScreenIdentifier
                .TipInputView
                .twentyBtn
                .rawValue
        ]
    }
    
    var customButton: XCUIElement {
        return app.buttons[
            ScreenIdentifier
                .TipInputView
                .customBtn
                .rawValue
        ]
    }
    
    var customAlertTxtField: XCUIElement {
        return app.textFields[
            ScreenIdentifier
                .TipInputView
                .customAlertTxtField
                .rawValue
        ]
    }
    
    
// MARK: SplitView
    
    var decreaseBtn: XCUIElement {
        return app.buttons[
            ScreenIdentifier
                .SplitView
                .decrementBtn
                .rawValue
        ]
    }
    
    var increaseBtn: XCUIElement {
        return app.buttons[
            ScreenIdentifier
                .SplitView
                .increaseBtn
                .rawValue
        ]
    }
    
    var quantityLabel: XCUIElement {
        return app.staticTexts[
            ScreenIdentifier
                .SplitView
                .quantityLabel
                .rawValue
        ]
    }
    
    
// MARK: Actions
    
    func enterBill(amount: Double){
        billInputTxtField.tap()
        billInputTxtField.typeText("\(amount)\n")
    }
    
    func selctTip(tip: Tip){
        switch tip {
        case .tenPercent:
            tenButton.tap()
        case .fifteenPercent:
            fifteenButton.tap()
        case .twentyPercent:
            twentyButton.tap()
        case .custom(let value):
            customButton.tap()
            XCTAssertTrue(customAlertTxtField.waitForExistence(timeout: 2.0))
            customAlertTxtField.typeText("\(value)\n")
        }
    }
    
    func selectIncrementBtn(numberOfTaps: Int){
        increaseBtn.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func selectDecrementBtn(numberOfTaps: Int){
        decreaseBtn.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func doubleTapHeaderView() {
        headerView.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    }
    
    enum Tip {
        case tenPercent
        case fifteenPercent
        case twentyPercent
        case custom(value: Int)
        
    }
    
}
