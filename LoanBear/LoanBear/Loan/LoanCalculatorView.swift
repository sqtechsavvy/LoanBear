//
//  LoanCalculatorView.swift
//  LoanBear
//
//  Created by Joey Serquina on 10/21/25.
//

import Combine
import SwiftUI

struct LoanCalculatorView: View {
    @StateObject private var viewModel = LoanCalculatorViewModel()
    @ObservedObject var authManager = AuthManager.shared
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "bearface")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.brown)
                
                Text("LoanBear Calculator")
                    .font(.title)
                    .fontWeight(.bold)
                
                Picker("Loan Type", selection: $viewModel.loanType) {
                    ForEach(LoanType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .accessibilityLabel("Select Loan Type")
                
                TextField("Loan Amount ($)", text: $viewModel.principal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .accessibilityLabel("Loan Amount")
                
                TextField("Duration (Months)", text: $viewModel.durationMonths)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .accessibilityLabel("Duration in Months")
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button(action: viewModel.computeLoan) {
                    Text("Compute Loan")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                if let total = viewModel.totalRepayment {
                    Text("Total Repayment: $\(total, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.green)
                }
            }
            .padding()
            .navigationTitle("LoanBear")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Sign Out") {
                        authManager.signOut()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
