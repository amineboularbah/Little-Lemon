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
let kIsLoggedIn = "is_logged_in_key"
let kPhoneNumber = "phone number key"

let kOrderStatuses = "order statuses key"
let kPasswordChanges = "password changes key"
let kSpecialOffers = "special offers key"
let kNewsletter = "news letter key"


struct OnBoarding: View {
    @State var firstName:String = ""
    @State var lastName: String = ""
    @State var email:String = ""
    @State var phoneNumber:String = ""
    @State var isLoggedIn: Bool = false
    @State var isKeyboardVisible = false
    @State var contentOffset: CGSize = .zero
    
    var body: some View {
        // Wrap the entire view inside a NavigationStack
        NavigationStack {
            ScrollView() {
                VStack(alignment: .leading) {
                    Header()
                    Hero()
                        .padding()
                        .background(AppColors.greenDark)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                    VStack{
                        Text("Subscribe to get started").font(.title)
                        // Text Fields
                        AppTextField(text: $firstName, labelText: "First Name", placeholder: "Ex: John")
                        
                        AppTextField(text: $lastName, labelText: "Last Name", placeholder: "Ex: Doe")
                        
                        AppTextField(text: $email, labelText: "Email", placeholder: "Ex: johndoe@example.com")
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        AppTextField(text: $phoneNumber, labelText: "Phone Number", placeholder: "Ex: (555) 555-1234")
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        
                        
                    }.padding()
                    
                    // Centered Button
                    HStack {
                        Spacer() // Push the button to the center
                        PrimaryButton(
                            isActive: $isLoggedIn,
                            text: "Subscribe",
                            onTap:{
                                print("Button tapped!")
                                handleCreateAccount()
                            },
                            width: 250,
                            height: 50
                        )
                        Spacer() // Balance the alignment
                    }
                }
                
                .frame(maxHeight: .infinity, alignment: .top)
                // Navigation destination tied to the isLoggedIn state
                .navigationDestination(isPresented: $isLoggedIn) {
                    Home() // Destination view
                }
                .onAppear {
                    if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                        isLoggedIn = true
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    // Function to validate email format
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    private func handleCreateAccount() {
        if !firstName.isEmpty && !lastName.isEmpty && isValidEmail(email) {
            // Save to UserDefaults
            UserDefaults.standard.set(firstName, forKey: kFirstName)
            UserDefaults.standard.set(lastName, forKey: kLastName)
            UserDefaults.standard.set(email, forKey: kEmail)
            UserDefaults.standard.set(true, forKey: kIsLoggedIn)

            // Navigate to Home
            isLoggedIn = true
        } else {
            print("Please fill in all fields correctly.")
        }
    }
}

#Preview {
    OnBoarding()
}
