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
                BrandImage()
                
                // Form
                VStack(spacing: 24) {
                    InputField(text: $email, label: "メールアドレス", placeholder: "入力してください")
                    
                    InputField(text: $password, label: "パスワード", placeholder: "半角英数字6文字以上", isSecureField: true)
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
