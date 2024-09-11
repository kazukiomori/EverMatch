//
//  AuthViewModel.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/09/01.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        userSession = Auth.auth().currentUser
        print("\(userSession?.email)")
        Task {
            await fetchCurrentUser()
        }
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
    @MainActor
    func createAccount(email: String, password: String, name: String, age: Int) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("ユーザー登録成功: \(result.user.email)")
            self.userSession = result.user
            let newUser = User(id: result.user.uid, name: name, email: email, age: age)
            await uploadUserData(withUser: newUser)
        } catch {
            print("ユーザー登録失敗: \(error.localizedDescription)")
        }
        
    }
    
    // Delete Account
    
    // Upload User Data
    private func uploadUserData(withUser user: User) async {
        do {
            let userData = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(userData)
            print("データ保存成功")
        } catch {
            print("データ保存失敗: \(error.localizedDescription)")
        }
    }
    
    private func fetchCurrentUser() async {
        guard let uid = self.userSession?.uid else { return }
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            self.currentUser = try snapshot.data(as: User.self)
        } catch {
            print("カレントユーザー取得失敗:\(error.localizedDescription)")
        }
    }
}
