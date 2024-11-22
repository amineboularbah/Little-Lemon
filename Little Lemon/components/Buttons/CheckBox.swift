//
//  CheckBox.swift
//  Little Lemon
//
//  Created by Amine on 22/11/2024.
//

import SwiftUI

struct CheckboxView: View {
    let label: String
    @Binding var isChecked: Bool

    var body: some View {
        HStack {
            Button(action: {
                isChecked.toggle()
                UserDefaults.standard.set(isChecked, forKey: label) // Save to UserDefaults
            }) {
                Image(systemName: isChecked ? "checkmark.square" : "square")
                    .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(isChecked ? .white : .gray) // Checkmark color
                                        .background(isChecked ? AppColors.greenDark : AppColors.white) // Background color for checked
                                        .cornerRadius(4) // Optional for rounded corners
                
            }
            .buttonStyle(PlainButtonStyle())
            .background(isChecked ? AppColors.greenDark : AppColors.white)
            
            Text(label)
                .font(.body)
        }
    }
}

#Preview {
    VStack {
        CheckboxView(label: "Example", isChecked: .constant(true))
        CheckboxView(label: "Another Example", isChecked: .constant(false))
    }
}
