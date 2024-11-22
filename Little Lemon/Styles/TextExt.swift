//
//  TextExt.swift
//  Little Lemon
//
//  Created by Amine on 22/11/2024.
//

import SwiftUICore

extension Text {
    func onboardingTextStyle() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.custom("Karla-Bold", size: 13))
    }
}
