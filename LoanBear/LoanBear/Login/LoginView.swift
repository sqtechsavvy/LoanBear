//
//  LoginView.swift
//  LoanBear
//
//  Created by Joey Serquina on 10/21/25.
//

import Combine
import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var showSignup = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "bearface")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.brown)
                
                Text("Welcome to LoanBear!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                
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
                
                Button(action: viewModel.login) {
                    Text(viewModel.isLoading ? "Logging in..." : "Log In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(viewModel.isLoading)
                
                Button("Sign Up for LoanBear") {
                    showSignup = true
                }
                .foregroundColor(.green)
            }
            .padding()
            .navigationDestination(isPresented: $showSignup) {
                SignupView()
            }
        }
    }
}
