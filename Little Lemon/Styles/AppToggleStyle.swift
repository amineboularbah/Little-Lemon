//
//  MyToggleStyle.swift
//  Little Lemon
//
//  Created by Amine on 22/11/2024.
//

import SwiftUI


struct AppToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                configuration.label
            }
        }
        .foregroundColor(configuration.isOn ?  AppColors.white : AppColors.greenDark)
        .padding(8)
        .background {
            if configuration.isOn {
                AppColors.greenDark
            }else {
                AppColors.lightGray
            }
        }
        .cornerRadius(24)
    }
}
