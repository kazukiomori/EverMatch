//
//  ListView.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/08/29.
//

import SwiftUI

struct ListView: View {
    @ObservedObject private var viewModel = ListViewModel()
    var body: some View {
        Group {
            if viewModel.users.count > 0 {
                NavigationStack {
                    VStack(spacing: 0) {
                        // cards
                        cards
                        
                        //action
                        actions
                    }
                    .background(.black, in: RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal, 6)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink {
                                MyPageView()
                            } label: {
                                Image("avatar")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 32, height: 32)
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
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
