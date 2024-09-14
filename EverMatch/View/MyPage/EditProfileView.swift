//
//  EditProfileView.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/09/08.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var name = ""
    @State var age = 0
    @State var message = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                // BackGround Color
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                // Edid field
                editField
            }
            .navigationTitle("プロフィール変更")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("変更") {
                        Task {
                            guard let currentUser = authViewModel.currentUser else { return }
                            await authViewModel.updateUserProfile(withId: currentUser.id , name: name, age: age, message: message)
                            dismiss()
                        }
                    }
                }
            }
            .font(.subheadline)
            .foregroundStyle(.primary)
        }
    }
}

#Preview {
    EditProfileView()
}

extension EditProfileView {
    
    private var editField: some View {
        VStack(spacing: 16) {
            // Photo picker
            PhotosPicker(selection: $authViewModel.selectedImage) {
                Group {
                    if let uiImage = authViewModel.profileImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .frame(width: 150)
                    } else if let urlString = authViewModel.currentUser?.photoUrl, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .frame(width: 150)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 150, height: 150)
                        }

                    } else {
                        ZStack {
                            Image("avatar")
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .frame(width: 150)
                            
                            Image(systemName: "photo.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.white.opacity(0.75))
                                .frame(width: 60)
                        }
                    }
                }
            }
            
             // Input area
            InputField(text: $name, label: "お名前", placeholder: "")
            PickerField(selection: $age, title: "年齢")
            InputField(text: $message, label: "メッセージ", placeholder: "入力してください", withDivider: false, isVertical: true)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
        }
        .padding()
        .onAppear {
            if let currentUser = authViewModel.currentUser {
                name = currentUser.name
                age = currentUser.age
                message = currentUser.message ?? ""
            }
        }
    }
}
