//
//  LoginView.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/09/01.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        NavigationStack {
            VStack {
                // image
                Image(systemName: "flame.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.red)
                    .frame(width: 120, height: 120)
                    .padding(.vertical, 32)
                
                // Form
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("メールアドレス")
                            .foregroundStyle(Color(.darkGray))
                            .fontWeight(.semibold)
                            .font(.footnote)
                        TextField("入力してください", text: $email)
                        Divider()
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Text("パスワード")
                            .foregroundStyle(Color(.darkGray))
                            .fontWeight(.semibold)
                            .font(.footnote)
                        SecureField("半角英数字6文字以上", text: $password)
                        Divider()
                    }
                    
                }
                
                // Button
                Button {
                    
                } label: {
                    HStack {
                        Text("ログイン")
                        Image(systemName: "arrow.right")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .background(.red)
                    .clipShape(Capsule())
                }
                .padding(.top, 24)
                
                Spacer()
                
                // Navigation
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("まだアカウントをお持ちでない方")
                        Text("会員登録")
                            .fontWeight(.bold)
                    }
                    .foregroundStyle(Color(.darkGray))
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    LoginView()
}
