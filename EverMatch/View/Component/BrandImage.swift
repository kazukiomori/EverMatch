//
//  BrandImage.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/09/01.
//

import SwiftUI

enum BrandImageSize: CGFloat {
    case large = 120
    case small = 32
}

struct BrandImage: View {
    let size: BrandImageSize
    var body: some View {
        Image(systemName: "flame.circle.fill")
            .resizable()
            .scaledToFill()
            .foregroundStyle(.red)
            .frame(width: size.rawValue, height: size.rawValue)
            .padding(.vertical, 32)
    }
}

#Preview {
    BrandImage(size: .large)
}
