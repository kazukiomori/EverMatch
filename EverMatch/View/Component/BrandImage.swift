//
//  BrandImage.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/09/01.
//

import SwiftUI

struct BrandImage: View {
    var body: some View {
        Image(systemName: "flame.circle.fill")
            .resizable()
            .scaledToFill()
            .foregroundStyle(.red)
            .frame(width: 120, height: 120)
            .padding(.vertical, 32)
    }
}

#Preview {
    BrandImage()
}
