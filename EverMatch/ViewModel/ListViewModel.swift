//
//  ListViewModel.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/08/30.
//

import Foundation

class ListViewModel {
    
    var users = [User]()
    
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
}
