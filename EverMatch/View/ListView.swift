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
                    ZStack(alignment: .bottom) {
                        // background
                        Color.black
                        
                        // image
                        Image("avatar")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100)
                        
                        // gradient
                        LinearGradient(colors: [.clear, .black], startPoint: .center, endPoint: .bottom)
                        
                        // information
                        VStack(alignment: .leading) {
                            HStack(alignment: .bottom) {
                                Text("ブルー")
                                    .font(.largeTitle.bold())
                                
                                Text("99")
                                    .font(.title2)
                                
                                Circle()
                                    .frame(width: 22, height: 22)
                            }
                            Text("よろしくお願いします。")
                                
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 15))
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
