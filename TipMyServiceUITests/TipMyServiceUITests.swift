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
}
