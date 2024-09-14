//
//  ListView.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/08/29.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject private var viewModel = ListViewModel()
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.users.count > 0 {
                    VStack(spacing: 0) {
                        // cards
                        cards
                        
                        //action
                        actions
                    }
                    .background(.black, in: RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal, 6)
                    .tint(.black)
                } else {
                    ProgressView()
                        .padding()
                        .tint(Color.white)
                        .background(Color.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .scaleEffect(1.5)
                    
                }
            }
            .navigationTitle("Ever Match")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BrandImage(size: .small)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        MyPageView()
                    } label: {
                        if let urlString = authViewModel.currentUser?.photoUrl, let url = URL(string: urlString) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 32, height: 32)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 32, height: 32)
                            }
                        } else {
                            Image("avatar")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                        }
                    }
                }
            }
        }
        .tint(.primary)
    }
}

#Preview {
    ListView()
}

extension ListView {
    private var cards: some View {
        ZStack {
            ForEach(viewModel.users.reversed()) { user in
                CardView(user: user) { isRedo in
                    viewModel.adjustIndex(isRedo: isRedo)
                }
            }
        }
    }
    
    private var actions: some View {
        HStack(spacing: 68) {
            ForEach(Action.allCases, id: \.self) { type in
                type.createActionButton(viewModel: viewModel)
            }
        }
        .foregroundStyle(.white)
        .frame(height: 100)
    }
}
