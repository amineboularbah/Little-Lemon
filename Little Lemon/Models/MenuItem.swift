import Foundation

struct MenuItem: Decodable {
    let title: String
    let image: String
    let price: String

    // Optional additional properties from the JSON
    let description: String? // Assuming description is optional
    let category: String? // Example of another optional property
    
    enum CodingKeys: String, CodingKey {
        case title
        case price
        case image
        case category
        case description = "description" // Maps JSON "description" to Swift's "description"
    }
}
