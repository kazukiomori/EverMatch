//
//  AuthViewModel.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/09/01.
//

import Foundation
import FirebaseAuth

class AuthViewModel {
    // Login
    
    // Logout
    
    // Create Account
    func createAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password)
    }
    
    // Delete Account
}
