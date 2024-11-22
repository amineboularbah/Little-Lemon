//
//  Header.swift
//  Little Lemon
//
//  Created by Amine on 22/11/2024.
//

import SwiftUI

struct Header: View {
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                Image("LittleLemonLogo").resizable()
                    .scaledToFit()
                    .frame(height: 60) // Adjust height to fit
                    .padding()
                Spacer()
            }
        }
        .frame(maxHeight: 60)
        .padding(.bottom)
        
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
