//
//  PrimaryButton.swift
//  Little Lemon
//
//  Created by Amine on 22/11/2024.
//

import SwiftUI

struct PrimaryButton: View {
    @Binding var isActive: Bool
    let text: String
    let onTap : (() -> Void)?
    let width: CGFloat?
    let height: CGFloat?
    var body: some View {
        Button(action: {
            if let onTap = onTap {
                onTap() // Safely call the action
            }
        }){
            Text(text)
                .padding(8)
                .font(.title3)
                .bold()
                
        }
        .disabled(isActive)
        .frame(width: width ?? 150, height: height ?? 45)
        .background((!isActive ? AppColors.greenDark : AppColors.lightGray).cornerRadius(8))
        .foregroundColor(!isActive ? AppColors.white : AppColors.greenDark)
    }
}

#Preview {
    PrimaryButton(isActive: .constant(false), text: "Click Me", onTap: nil, width: nil, height: nil)
}
