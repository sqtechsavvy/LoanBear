//
//  LoanCalculatorViewModel.swift
//  LoanBear
//
//  Created by Joey Serquina on 10/21/25.
//

import Combine

class LoanCalculatorViewModel: ObservableObject {
    @Published var principal: String = ""
    @Published var durationMonths: String = ""
    @Published var loanType: LoanType = .personal
    @Published var totalRepayment: Double? = nil
    @Published var monthlyPayment: Double? = nil
    @Published var errorMessage: String? = nil
    
    func computeLoan() {
        guard let principalDouble = Double(principal), principalDouble > 0,
              let months = Int(durationMonths), months > 0 else {
            errorMessage = "Please enter valid positive numbers for amount and duration."
            totalRepayment = nil
            monthlyPayment = nil
            return
        }
        
        errorMessage = nil
        let interest = principalDouble * 0.10 * Double(months)
        totalRepayment = principalDouble + interest
        monthlyPayment = totalRepayment! / Double(months)
    }
}
