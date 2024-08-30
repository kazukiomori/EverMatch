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
