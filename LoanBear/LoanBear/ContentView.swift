//
//  ContentView.swift
//  LoanBear
//
//  Created by Joey Serquina on 10/21/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var authManager = AuthManager.shared
    
    var body: some View {
        if authManager.isLoggedIn {
            LoanCalculatorView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
