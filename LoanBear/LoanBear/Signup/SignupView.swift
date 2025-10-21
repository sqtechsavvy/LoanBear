//
//  SignupView.swift
//  LoanBear
//
//  Created by Joey Serquina on 10/21/25.
//

import Combine
import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = SignupViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "bearface")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.brown)
            
            Text("Sign Up for LoanBear")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityLabel("Username")
            
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .accessibilityLabel("Email")
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityLabel("Password")
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button(action: viewModel.signup) {
                Text(viewModel.isLoading ? "Signing up..." : "Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(viewModel.isLoading)
            
            Button("Already have an account? Log In") {
                dismiss()
            }
            .foregroundColor(.green)
        }
        .padding()
    }
}
