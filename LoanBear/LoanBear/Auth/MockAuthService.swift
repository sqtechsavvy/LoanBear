//
//  MockAuthService.swift
//  LoanBear
//
//  Created by Joey Serquina on 10/21/25.
//

import Combine
import SwiftUI

struct User: Codable {
    let username: String
    let email: String
    let password: String // In production, hash passwords
}

enum LoanType: String, CaseIterable, Identifiable {
    case car = "Car Loan"
    case personal = "Personal Loan"
    case home = "Home Loan"
    
    var id: Self { self }
}

class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    static let shared = AuthManager()
    private init() {}
    
    func signOut() {
        isLoggedIn = false
        // In real app, clear tokens, etc.
    }
}

protocol AuthServiceProtocol {
    func login(email: String, password: String) -> AnyPublisher<Bool, Error>
    func signup(username: String, email: String, password: String) -> AnyPublisher<Bool, Error>
}

class MockAuthService: AuthServiceProtocol {
    func login(email: String, password: String) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if email == "test@example.com" && password == "password" {
                    promise(.success(true))
                } else {
                    promise(.failure(NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signup(username: String, email: String, password: String) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if email.contains("@") {
                    promise(.success(true))
                } else {
                    promise(.failure(NSError(domain: "AuthError", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid email"])))
                }
            }
        }.eraseToAnyPublisher()
    }
}
