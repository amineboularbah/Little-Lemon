//
//  Home.swift
//  Little Lemon
//
//  Created by Amine on 20/11/2024.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView{
            Menu().tabItem({
                Label("Menu", systemImage: "list.dash")
            })
            
            Text("Settings").font(.title).tabItem({
                Label("Settings", systemImage: "menucard")
            })

        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
