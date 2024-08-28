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
            imageLayer
            
            // gradient
            LinearGradient(colors: [.clear, .black], startPoint: .center, endPoint: .bottom)
            
            // information
            informationLayer
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    CardView()
}

extension CardView {
    private var imageLayer: some View {
        Image("user01")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100)
    }
    
    private var informationLayer: some View {
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
}
