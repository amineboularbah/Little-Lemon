import SwiftUI

/// This will basically just help you access the colors in Assets
/// Instead of using hardcoded value everytime you need a color
/// centralizing them here make it easier to access through enums and less risk to make mistakes when inserting the color name
enum AppColors {
    static let greenLight = Color("GreenLight")
    static let greenDark = Color("GreenDark")
    static let yellow = Color("Yellow")
    static let orange = Color("Orange")
    static let orangeLight = Color("OrangeLight")
    static let lightGray = Color("LightGray")
    static let darkGray = Color("DarkGray")
    static let white = Color("White")
    static let black = Color("Black")
}
