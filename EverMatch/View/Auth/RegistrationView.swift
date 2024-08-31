//
//  RegistrationView.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/09/01.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var name = ""
    @State private var age = 18
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
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
                    Text("お名前")
                        .foregroundStyle(Color(.darkGray))
                        .fontWeight(.semibold)
                        .font(.footnote)
                    TextField("入力してください", text: $name)
                    Divider()
                }
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("年齢")
                            .foregroundStyle(Color(.darkGray))
                            .fontWeight(.semibold)
                            .font(.footnote)
                        Spacer()
                        Picker(selection: $age) {
                            ForEach(18..<100) { number in
                                Text("\(number)")
                                    .tag(number)
                            }
                        } label: {
                            Text("年齢")
                        }
                        .tint(.black)
                    }
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
                VStack(alignment: .leading, spacing: 12) {
                    Text("パスワード(確認用)")
                        .foregroundStyle(Color(.darkGray))
                        .fontWeight(.semibold)
                        .font(.footnote)
                    SecureField("もう一度入力してください", text: $confirmPassword)
                    Divider()
                }
                
            }
            
            // Button
            Button {
                
            } label: {
                HStack {
                    Text("登録")
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
                
            } label: {
                HStack {
                    Text("すでにアカウントをお持ちの方")
                    Text("ログイン")
                        .fontWeight(.bold)
                }
                .foregroundStyle(Color(.darkGray))
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    RegistrationView()
}
