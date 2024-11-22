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
    
    var body: some View {
        Button(action: {
            onTap!()
        }){
            Text(text)
                .padding(8)
                
                .bold()
                .frame(maxWidth: .infinity)
                
        }
        .disabled(!isActive)
        .background(AppColors.yellow.cornerRadius(8))
        .foregroundColor(AppColors.black)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(maxWidth: .infinity) // Use maxWidth for full width
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(AppColors.orange, lineWidth: 1 ))
    }
}

#Preview {
    YellowButton(isActive: .constant(true), text: "Click Me", onTap: nil)
}
