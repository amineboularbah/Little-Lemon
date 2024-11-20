//
//  OnBoarding.swift
//  Little Lemon
//
//  Created by Amine on 20/11/2024.
//

import SwiftUI

// Global Keys for UserDefaults
let kFirstName = "first_name_key"
let kLastName = "last_name_key"
let kEmail = "email_key"


struct OnBoarding: View {
    @State var firstName:String = ""
    @State var lastName: String = ""
    @State var email:String = ""
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        // Wrap the entire view inside a NavigationStack
        NavigationStack {
            VStack(spacing: 20) {
                // Text Fields
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()

                // Register Button
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && isValidEmail(email) {
                        // Save to UserDefaults
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)

                        // Navigate to Home
                        isLoggedIn = true
                    } else {
                        print("Please fill in all fields correctly.")
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding()
            // Navigation destination tied to the isLoggedIn state
            .navigationDestination(isPresented: $isLoggedIn) {
                Home() // Destination view
            }
        }
    }
    
    // Function to validate email format
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
}

#Preview {
    OnBoarding()
}
