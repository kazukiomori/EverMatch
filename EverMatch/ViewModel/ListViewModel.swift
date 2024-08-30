//
//  ListViewModel.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/08/30.
//

import Foundation

class ListViewModel {
    
    var users = [User]()
    
    private var currentIndex = 0
    
    init() {
        self.users = getMockUsere()
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
    
    func adjustIndex(isRedo: Bool) {
        if isRedo {
            currentIndex -= 1
        } else {
            currentIndex += 1
        }
    }
    
    func nopeButtonTapped() {
        if currentIndex >= users.count { return }
        
        NotificationCenter.default.post(name: NSNotification.Name("NOPEACTION"), object: nil, userInfo: ["id": users[currentIndex].id])
    }
    
    func likeButtonTapped() {
        if currentIndex >= users.count { return }
        
        NotificationCenter.default.post(name: NSNotification.Name("LIKEACTION"), object: nil, userInfo: ["id": users[currentIndex].id])
    }
    
    func redoButtonTapped() {
        if currentIndex <= 0 { return }
        
        NotificationCenter.default.post(name: NSNotification.Name("REDOACTION"), object: nil, userInfo: ["id": users[currentIndex - 1].id])
    }
    
    
}
