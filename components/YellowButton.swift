//
//  YellowButton.swift
//  Little Lemon
//
//  Created by Amine on 22/11/2024.
//

import SwiftUI

struct YellowButton: View {
    @Binding var isActive: Bool
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
        .disabled(!isActive)
        .frame(width: width, height: height)
        .background(AppColors.yellow.cornerRadius(8))
        .foregroundColor(AppColors.black)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(AppColors.orange, lineWidth: 1 ))
    }
}

#Preview {
    YellowButton(isActive: .constant(true), text: "Click Me", onTap: nil)
}
