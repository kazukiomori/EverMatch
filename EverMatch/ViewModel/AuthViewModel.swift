//
//  AuthViewModel.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/09/01.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        userSession = Auth.auth().currentUser
        print("\(userSession?.email)")
    }
    
    // Login
    @MainActor
    func login(email: String, passwaord: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: passwaord)
            print("ログイン成功: \(result.user.email)")
            self.userSession = result.user
        } catch{
            print("ログイン失敗: \(error.localizedDescription)")
        }
        
    }
    
    // Logout
    func logout() {
        do {
            try Auth.auth().signOut()
            print("ログアウト成功")
            self.userSession =  nil
        } catch {
            print("ログアウト失敗: \(error.localizedDescription)")
        }
        
    }
    
    // Create Account
    func createAccount(email: String, password: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("ユーザー登録成功: \(result.user.email)")
            self.userSession = result.user
        } catch {
            print("ユーザー登録失敗: \(error.localizedDescription)")
        }
        
    }
    
    // Delete Account
}
