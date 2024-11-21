import Foundation

struct MenuItem: Decodable {
    let title: String
    let image: String
    let price: String

    // Optional additional properties from the JSON
    let description: String? // Assuming description is optional
    let category: String? // Example of another optional property
}
