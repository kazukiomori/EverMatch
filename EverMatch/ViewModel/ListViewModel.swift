//
//  ListViewModel.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/08/30.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ListViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    private var currentIndex = 0
    
    init() {
        Task {
            self.users = await fetchUsers()
        }
    }
    
    private func getMockUsere() -> [User] {
        return [
            User.MOCK_USER1,
            User.MOCK_USER2,
            User.MOCK_USER3,
            User.MOCK_USER4,
            User.MOCK_USER5,
            User.MOCK_USER6,
            User.MOCK_USER7
        ]
    }
    
    private func fetchUsers() async -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return []}
        
        do {
            let snapshot = try await Firestore.firestore().collection("users").getDocuments()
            var tempUsers = [User]()
            for document in snapshot.documents {
                let user = try document.data(as: User.self)
                if currentUid != user.id {
                    tempUsers.append(user)
                }
            }
            return tempUsers
        } catch {
            print("ユーザの取得失敗")
            return []
        }
        
    }
    
    func adjustIndex(isRedo: Bool) {
        if isRedo {
            currentIndex -= 1
        } else {
            currentIndex += 1
        }
    }
    
    func tappedHandler(action: Action) {
        switch action {
        case .nope, .like:
            if currentIndex >= users.count { return }
            
        case .redo:
            if currentIndex <= 0 { return }
            
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"),
                                        object: nil,
                                        userInfo: ["id": action == .redo ? users[currentIndex - 1].id : users[currentIndex].id, "action": action])
    }
    
}
