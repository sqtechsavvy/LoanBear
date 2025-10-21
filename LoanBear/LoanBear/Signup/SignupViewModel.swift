//
//  SignupViewModel.swift
//  LoanBear
//
//  Created by Joey Serquina on 10/21/25.
//

import Foundation
import Combine

class SignupViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let authService: AuthServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(authService: AuthServiceProtocol = MockAuthService()) {
        self.authService = authService
    }
    
    func signup() {
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        authService.signup(username: username, email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { success in
                if success {
                    AuthManager.shared.isLoggedIn = true
                }
            }
            .store(in: &cancellables)
    }
}
