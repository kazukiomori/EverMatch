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
    func createAccount(email: String, password: String) async {
        //Auth.auth().createUser(withEmail: email, password: password)
        
        //        Auth.auth().createUser(withEmail: email, password: password) { result, error in
        //            print("Firebaseからの結果通知")
        //
        //            if let error = error {
        //                print("ユーザー登録失敗: \(error.localizedDescription)")
        //            }
        //
        //            if let result = result {
        //                print("ユーザー登録成功: \(result.user.email)")
        //            }
        //        }
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("ユーザー登録成功: \(result.user.email)")
        } catch {
            print("ユーザー登録失敗: \(error.localizedDescription)")
        }
        
    }
    
    // Delete Account
}
