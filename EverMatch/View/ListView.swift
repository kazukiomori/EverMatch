//
//  ListView.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/08/29.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        VStack(spacing: 0) {
            // cards
            ZStack {
                ForEach(0..<5) { _ in
                    Color.gray
                }
            }
            
            //action
            HStack(spacing: 68) {
                Circle()
                    .frame(width: 50, height: 50)
                Circle()
                    .frame(width: 50, height: 50)
                Circle()
                    .frame(width: 50, height: 50)
            }
            .foregroundStyle(.white)
            .frame(height: 100)
        }
        .background(.black, in: RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 6)
    }
}

#Preview {
    ListView()
}
