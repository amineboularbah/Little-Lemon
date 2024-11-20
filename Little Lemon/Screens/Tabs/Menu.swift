//
//  Menu.swift
//  Little Lemon
//
//  Created by Amine on 20/11/2024.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack(spacing: 10){
            Text("Little Lemon").font(.largeTitle)
            Text("Chicago").font(.headline)
            Text("This is a simple app to learn SwiftUI. it is about a restaurant called little lemon. we will be showing the menu and other stuff. We will be applying what we have learned")
                .font(.body)
                .multilineTextAlignment(.center)
            
            List{
                
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding()
    }
}

#Preview {
    Menu()
}
