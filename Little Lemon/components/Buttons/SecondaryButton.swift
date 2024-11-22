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
    let width: CGFloat?
    let height: CGFloat?
    var body: some View {
        Button(action: {
            onTap!()
        }){
            Text(text)
                .padding(8)
                
                .bold()
                
        }
        .frame(width: width ?? 100, height: height ?? 50)
        .foregroundColor(AppColors.greenDark)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(AppColors.greenDark, lineWidth: 1.5) // Border color and width
        )
    }
}

#Preview {
    SecondaryButton(text: "Click Me", onTap: nil, width: nil, height: nil)
}
