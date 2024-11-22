//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Amine on 20/11/2024.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    // Fetch data from UserDefaults
    let firstName: String =
        UserDefaults.standard.string(forKey: kFirstName) ?? ""
    let lastName: String = UserDefaults.standard.string(forKey: kLastName) ?? ""
    let email: String = UserDefaults.standard.string(forKey: kEmail) ?? ""

    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .overlay(Circle().stroke(Color.black, lineWidth: 1))
            // Text Fields Displaying Data from UserDefaults
            Text("First Name: \(firstName)")
                .font(.headline)
                .padding()

            Text("Last Name: \(lastName)")
                .font(.headline)
                .padding()

            Text("Email: \(email)")
                .font(.headline)
                .padding()
            Spacer()
            // Logout Button
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)  // Mark user as logged out
                self.presentation.wrappedValue.dismiss()  // Go back to Onboarding
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(10)

        }
        .padding()
    }
}

#Preview {
    UserProfile()
}
