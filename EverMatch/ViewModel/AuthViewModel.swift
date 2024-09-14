//
//  AuthViewModel.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/09/01.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import PhotosUI
import SwiftUI

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage()
            }
        }
    }
    @Published var profileImage: UIImage?
    
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
            
            await fetchCurrentUser()
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
            self.currentUser = nil
            self.profileImage = nil
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
            
            await fetchCurrentUser()
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
    
    @MainActor
    private func fetchCurrentUser() async {
        guard let uid = self.userSession?.uid else { return }
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            self.currentUser = try snapshot.data(as: User.self)
        } catch {
            print("カレントユーザー取得失敗:\(error.localizedDescription)")
        }
    }
    
    func updateUserProfile(withId id: String, name: String, age: Int, message: String) async {
        var data: [AnyHashable: Any] = [
            "name": name,
            "age": age,
            "message": message]
        
        if let urlString = await uploadImage() {
            data["photoUrl"] = urlString
        }
        
        do {
            try await Firestore.firestore().collection("users").document(id).updateData(data)
            await fetchCurrentUser()
        } catch {
            print("プロフィール更新失敗\(error.localizedDescription)")
        }
    }
    
    // Load Image
    @MainActor
    private func loadImage() async {
        guard let image = selectedImage else { return }
        do {
            guard let data = try await image.loadTransferable(type: Data.self) else { return }
            self.profileImage = UIImage(data: data)
        } catch {
            print("参照データのロード失敗: \(error.localizedDescription)")
        }
    }
    
    // Upload Image Data
    private func uploadImage() async -> String? {
        let filename = NSUUID().uuidString
        let starageRef = Storage.storage().reference(withPath: "/user_images/\(filename)")
        
        guard let uiImage = self.profileImage else { return nil }
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return nil }
        do {
            _ = try await starageRef.putDataAsync(imageData)
            print("画像アップロード成功")
            
            let urlString = try await starageRef.downloadURL().absoluteString
            return urlString
        } catch {
            print("画像アップロード失敗: \(error.localizedDescription)")
            return nil
        }
        
    }
}
