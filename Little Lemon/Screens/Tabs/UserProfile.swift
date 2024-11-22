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
    @State private var isLoggedOut = false
    @State private var orderStatuses = UserDefaults.standard.bool(
        forKey: kOrderStatuses)
    @State private var passwordChanges = UserDefaults.standard.bool(
        forKey: kPasswordChanges)
    @State private var specialOffers = UserDefaults.standard.bool(
        forKey: kSpecialOffers)
    @State private var newsletter = UserDefaults.standard.bool(
        forKey: kNewsletter)
    @State private var phoneNumber =
        UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
    @State private var firstName: String =
        UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State private var lastName: String =
        UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State private var email: String =
        UserDefaults.standard.string(forKey: kEmail) ?? ""

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Personal Information")
                    .font(.title3)
                    .frame(alignment: .leading)
                Text("Avatar")
                    .onboardingTextStyle()
                HStack(spacing: 10) {
                    Image("profile-image-placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 75)
                        .clipShape(Circle())
                        .padding(.trailing)
                    PrimaryButton(
                        isActive: .constant(true), text: "Change", onTap: nil,
                        width: 100, height: 45)

                    SecondaryButton(
                        text: "Remove", onTap: nil, width: 100, height: 45)

                    Spacer()
                }

                // Text Fields Displaying Data from UserDefaults
                AppTextField(
                    text: $firstName, labelText: "First Name",
                    placeholder: "Ex: John")

                AppTextField(
                    text: $lastName, labelText: "Last Name",
                    placeholder: "Ex: Doe")

                AppTextField(
                    text: $email, labelText: "Email",
                    placeholder: "Ex: johndoe@example.com"
                )
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)

                AppTextField(
                    text: $lastName, labelText: "Phone Number",
                    placeholder: "Ex: (555) 555-1234"
                )
                .keyboardType(.phonePad)
                Text("Email notifications")
                    .font(.title3)
                    .frame(alignment: .leading)

                CheckboxView(label: "Order statuses", isChecked: $orderStatuses)
                CheckboxView(
                    label: "Password changes", isChecked: $passwordChanges)
                CheckboxView(label: "Special offers", isChecked: $specialOffers)
                CheckboxView(label: "Newsletter", isChecked: $newsletter)
                Spacer().frame(width: 100, height: 25)
                // Logout Button
                YellowButton(
                    isActive: .constant(true), text: "Log out",
                    onTap: handleLogout
                ).frame(maxWidth: .infinity)  // Make it take the full width

                Spacer().frame(width: 100, height: 15)
                HStack(alignment: .center, spacing: 10) {
                    Spacer()
                    SecondaryButton(
                        text: "Discard Changes", onTap: handleDiscardChanged,
                        width: 170, height: 45)

                    PrimaryButton(
                        isActive: .constant(true), text: "Save Changes",
                        onTap: handleSaveChanges,
                        width: 170, height: 45)
                    Spacer()

                }

            }.frame(maxWidth: .infinity)

        }.frame(maxWidth: .infinity)
            .padding(.horizontal, 24)

    }

    private func handleSaveChanges() {
        UserDefaults.standard.set(firstName, forKey: kFirstName)
        UserDefaults.standard.set(lastName, forKey: kLastName)
        UserDefaults.standard.set(email, forKey: kEmail)
        UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
        UserDefaults.standard.set(orderStatuses, forKey: kOrderStatuses)
        UserDefaults.standard.set(passwordChanges, forKey: kPasswordChanges)
        UserDefaults.standard.set(specialOffers, forKey: kSpecialOffers)
        UserDefaults.standard.set(newsletter, forKey: kNewsletter)
    }

    private func handleDiscardChanged() {

        firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
        lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
        email = UserDefaults.standard.string(forKey: kEmail) ?? ""
        phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
        orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
        passwordChanges = UserDefaults.standard.bool(forKey: kPasswordChanges)
        specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
        newsletter = UserDefaults.standard.bool(forKey: kNewsletter)
       
    }
    private func handleLogout() {

        UserDefaults.standard.set(false, forKey: kIsLoggedIn)
        UserDefaults.standard.set(false, forKey: kIsLoggedIn)
        UserDefaults.standard.set("", forKey: kFirstName)
        UserDefaults.standard.set("", forKey: kLastName)
        UserDefaults.standard.set("", forKey: kEmail)
        UserDefaults.standard.set("", forKey: kPhoneNumber)
        UserDefaults.standard.set(false, forKey: kOrderStatuses)
        UserDefaults.standard.set(false, forKey: kPasswordChanges)
        UserDefaults.standard.set(false, forKey: kSpecialOffers)
        UserDefaults.standard.set(false, forKey: kNewsletter)
        isLoggedOut = true
        self.presentation.wrappedValue.dismiss()

    }
}

#Preview {
    UserProfile()
}
