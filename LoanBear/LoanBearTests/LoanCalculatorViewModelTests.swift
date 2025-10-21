//
//  LoanCalculatorViewModelTests.swift
//  LoanBearTests
//
//  Created by Joey Serquina on 10/21/25.
//


#if DEBUG
import XCTest
@testable import LoanBear

class LoanCalculatorViewModelTests: XCTestCase {
    func testComputeLoanSuccess() {
        let viewModel = LoanCalculatorViewModel()
        
        viewModel.principal = "1000"
        viewModel.durationMonths = "12"
        viewModel.computeLoan()
        
        XCTAssertEqual(viewModel.totalRepayment, 2200.0) // 1000 + (1000 * 0.10 * 12) = 1000 + 1200 = 2200
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testComputeLoanInvalidInput() {
        let viewModel = LoanCalculatorViewModel()
        
        viewModel.principal = "abc"
        viewModel.durationMonths = "12"
        viewModel.computeLoan()
        
        XCTAssertNil(viewModel.totalRepayment)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    // Add more tests...
}
#endif
