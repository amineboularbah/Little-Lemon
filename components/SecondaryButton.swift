//
//  SecondaryButton.swift
//  Little Lemon
//
//  Created by Amine on 22/11/2024.
//


import SwiftUI

struct SecondaryButton: View {
    let text: String
    let onTap : (() -> Void)?
    let height: CGFloat = 50
    let width: CGFloat = 150
    var body: some View {
        Button(action: {
            onTap!()
        }){
            Text(text)
                .padding(8)
                .font(.title3)
                .bold()
                
        }
        .frame(width: width, height: height)
        .foregroundColor(AppColors.greenDark)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(AppColors.greenDark, lineWidth: 1.5) // Border color and width
        )
    }
}

#Preview {
    SecondaryButton(text: "Click Me", onTap: nil)
}
