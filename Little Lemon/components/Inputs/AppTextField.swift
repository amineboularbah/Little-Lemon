//
//  AppTextField.swift
//  Little Lemon
//
//  Created by Amine on 22/11/2024.
//

import SwiftUI

struct AppTextField: View {
    @Binding var text: String
    var labelText: String
    var placeholder: String = "Enter text"
    var cornerRadius: CGFloat = 8
    var borderColor: Color = AppColors.lightGray
    var backgroundColor: Color = AppColors.lightGray.opacity(0.4)
    var textColor: Color = AppColors.black
    var labelColor: Color = .gray
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(labelText)
                .font(.caption)
                .foregroundColor(labelColor)
                .onboardingTextStyle()
            TextField(placeholder, text: $text)
                .padding(10)
                .background(backgroundColor)
                .foregroundColor(textColor)
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: 1)
                )
                .frame(height: 45)
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    AppTextField(text: .constant("Initial Value"), labelText: "Label")
}
