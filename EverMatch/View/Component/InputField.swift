//
//  InputField.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/09/01.
//

import SwiftUI

struct InputField: View {
    
    @Binding var text: String
    let label: String
    let placeholder: String
    var isSecureField = false
    var withDivider = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(label)
                .foregroundStyle(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            if isSecureField {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
            if withDivider {
                Divider()
            }
        }
    }
}

#Preview {
    InputField(text: .constant(""), label: "メールアドレス", placeholder: "入力してください")
}
