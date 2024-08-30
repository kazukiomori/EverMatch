//
//  ListView.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/08/29.
//

import SwiftUI

struct ListView: View {
    private let viewModel = ListViewModel()
    var body: some View {
        VStack(spacing: 0) {
            // cards
            cards
            
            //action
            actions
        }
        .background(.black, in: RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 6)
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
            Button(action: {
                viewModel.tappedHandler(action: .nope)
            }, label: {
                Image(systemName: "xmark")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.red)
                    .background{
                        Circle()
                            .stroke(.red, lineWidth: 1)
                            .frame(width: 60, height: 60)
                    }
            })
            
            Button(action: {
                viewModel.tappedHandler(action: .redo)
            }, label: {
                Image(systemName: "arrow.counterclockwise")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.yellow)
                    .background{
                        Circle()
                            .stroke(.yellow, lineWidth: 1)
                            .frame(width: 50, height: 50)
                    }
            })
            
            Button(action: {
                viewModel.tappedHandler(action: .like)
            }, label: {
                Image(systemName: "heart")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.mint)
                    .background{
                        Circle()
                            .stroke(.mint, lineWidth: 1)
                            .frame(width: 60, height: 60)
                    }
            })
        }
        .foregroundStyle(.white)
        .frame(height: 100)
    }
}
