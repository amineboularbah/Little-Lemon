//
//  Hero.swift
//  LittleLemonApp
//
//  Created by Amine on 22/11/2024.
//

import SwiftUI

struct Hero: View {
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Little Lemon")
                        .foregroundColor(AppColors.yellow)
                        .font(.displayFont())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Chicago")
                        .foregroundColor(.white)
                        .font(.subTitleFont())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer(minLength: 5)
                    Text("""
                     We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.
                     """)
                    .foregroundColor(.white)
                    .font(.leadText())
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Image("Hero")
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .frame(maxWidth: 140, maxHeight: 140)
                    .clipShape(Rectangle())
                    .cornerRadius(16)
            }
        }
    }
}

struct Hero_Previews: PreviewProvider {
    static var previews: some View {
        Hero()
            .padding()
            .background(AppColors.greenDark)
            .frame(maxWidth: .infinity, maxHeight: 240)
    }
}
