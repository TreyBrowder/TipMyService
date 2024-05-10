//
//  TipMyServiceUITests.swift
//  TipMyServiceUITests
//
//  Created by Trey Browder on 5/8/24.
//

import XCTest

final class TipMyServiceUITests: XCTestCase {

    private var app: XCUIApplication!
    
    private var screen: TipCalcScreen {
        TipCalcScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testResultViewDefaultValues() {
        XCTAssertEqual(screen.ttlAmountPerPersonValueLabel.label, "$0")
        XCTAssertEqual(screen.ttlBillValueLabel.label, "$000")
        XCTAssertEqual(screen.ttlTipValueLabel.label, "$000")
    }
    
    func testResultViewWrongDefaultValue(){
        XCTAssertNotEqual(screen.ttlAmountPerPersonValueLabel.label, "$10")
        XCTAssertNotEqual(screen.ttlBillValueLabel.label, "$2300")
        XCTAssertNotEqual(screen.ttlTipValueLabel.label, "$232300")
    }
    
    ///Test regular Tip Flow
    func testRegularTip() {
      // User enters a $100 bill
      screen.enterBill(amount: 100)
      XCTAssertEqual(screen.ttlAmountPerPersonValueLabel.label, "$100")
      XCTAssertEqual(screen.ttlBillValueLabel.label, "$100")
      XCTAssertEqual(screen.ttlTipValueLabel.label, "$0")
    
      // User selects 10%
      screen.selectTip(tip: .tenPercent)
      XCTAssertEqual(screen.ttlAmountPerPersonValueLabel.label, "$110")
      XCTAssertEqual(screen.ttlBillValueLabel.label, "$110")
      XCTAssertEqual(screen.ttlTipValueLabel.label, "$10")

      // User selects 15%
      screen.selectTip(tip: .fifteenPercent)
      XCTAssertEqual(screen.ttlAmountPerPersonValueLabel.label, "$115")
      XCTAssertEqual(screen.ttlBillValueLabel.label, "$115")
      XCTAssertEqual(screen.ttlTipValueLabel.label, "$15")

      // User selects 20%
      screen.selectTip(tip: .twentyPercent)
      XCTAssertEqual(screen.ttlAmountPerPersonValueLabel.label, "$120")
      XCTAssertEqual(screen.ttlBillValueLabel.label, "$120")
      XCTAssertEqual(screen.ttlTipValueLabel.label, "$20")

      // User splits the bill by 4
      screen.selectIncrementBtn(numberOfTaps: 3)
      XCTAssertEqual(screen.ttlAmountPerPersonValueLabel.label, "$30")
      XCTAssertEqual(screen.ttlBillValueLabel.label, "$120")
      XCTAssertEqual(screen.ttlTipValueLabel.label, "$20")

      // User splits the bill by 2
      screen.selectDecrementBtn(numberOfTaps: 2)
      XCTAssertEqual(screen.ttlAmountPerPersonValueLabel.label, "$60")
      XCTAssertEqual(screen.ttlBillValueLabel.label, "$120")
      XCTAssertEqual(screen.ttlTipValueLabel.label, "$20")
    }
    
    func testCustomTipAndSplitBillBy2() {
      screen.enterBill(amount: 300)
      screen.selectTip(tip: .custom(value: 200))
      screen.selectIncrementBtn(numberOfTaps: 1)
      XCTAssertEqual(screen.ttlBillValueLabel.label, "$500")
      XCTAssertEqual(screen.ttlTipValueLabel.label, "$200")
      XCTAssertEqual(screen.ttlAmountPerPersonValueLabel.label, "$250")
    }
    
    func testResetButton() {
      screen.enterBill(amount: 300)
      screen.selectTip(tip: .custom(value: 200))
      screen.selectIncrementBtn(numberOfTaps: 1)
      screen.doubleTapHeaderView()
      XCTAssertEqual(screen.ttlBillValueLabel.label, "$0")
      XCTAssertEqual(screen.ttlTipValueLabel.label, "$0")
      XCTAssertEqual(screen.ttlAmountPerPersonValueLabel.label, "$0")
      XCTAssertEqual(screen.billInputTxtField.label, "")
      XCTAssertEqual(screen.quantityLabel.label, "1")
      XCTAssertEqual(screen.customBtn.label, "Custom tip")
    }

}
