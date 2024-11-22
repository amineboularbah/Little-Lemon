//
//  DishCard.swift
//  Little Lemon
//
//  Created by Amine on 22/11/2024.
//

import SwiftUI

struct DishCard: View {
    var title: String
    var description: String
    var price: String
    var imageURL: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Left Side: Text
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(AppColors.greenDark)
                    .lineLimit(2) // Truncate after 2 lines

                Text("$\(price)")
                    .font(.body)
                    .foregroundColor(AppColors.greenDark)
                    .bold()
            }
            
            Spacer()
            
            // Right Side: Image
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView() // Placeholder while loading
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100) // Fixed size for the image
                        .clipShape(RoundedRectangle(cornerRadius: 8)) // Rounded corners
                case .failure:
                    Image(systemName: "photo")
                        .frame(width: 100, height: 100)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                @unknown default:
                    EmptyView()
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2) // Add subtle shadow
    }
}


#Preview {
    DishCard(
        title: "Brushetta",
        description: "Our Bruschetta is made from grilled bread that has been smeared with garlic...",
        price: "7.99",
        imageURL: "https://via.placeholder.com/150" // Replace with actual image URL
    )
    .padding()
    .previewLayout(.sizeThatFits) // Adjust preview layout
}
