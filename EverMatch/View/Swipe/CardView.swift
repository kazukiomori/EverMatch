//
//  CardView.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/08/29.
//

import SwiftUI

struct CardView: View {
    var body: some View {
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

#Preview {
    CardView()
}
