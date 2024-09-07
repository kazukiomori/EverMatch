//
//  MyPageView.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/09/06.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        List {
            // User info
            userInfo
            
            // System info
            Section("一般") {
                MyPageRow(iconName: "gear", label: "バージョン", tintColor: .gray, value: "1.0.0")
            }
            
            // Navigation
            Section("アカウント") {
                Button {
                    
                } label: {
                    HStack(spacing: 16) {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .imageScale(.large)
                            .foregroundStyle(.red)
                        
                        Text("プロフィール変更")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                    }
                }
                
                Button {
                    
                } label: {
                    HStack(spacing: 16) {
                        Image(systemName: "arrow.left.circle.fill")
                            .imageScale(.large)
                            .foregroundStyle(.red)
                        
                        Text("プロフィール変更")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                    }
                }
                
                Button {
                    
                } label: {
                    HStack(spacing: 16) {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                            .foregroundStyle(.red)
                        
                        Text("プロフィール変更")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    MyPageView()
}

extension MyPageView {
    
    private var userInfo: some View {
        Section {
            HStack(spacing: 16) {
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("ブルー")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    Text("ブルー")
                        .font(.footnote)
                        .tint(.gray)
                }
            }
        }
    }
}
