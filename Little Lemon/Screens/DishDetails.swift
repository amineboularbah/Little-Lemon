import SwiftUI

struct DishDetails: View {
    let dish: Dish

    var body: some View {
        VStack(spacing: 20) {
            // Dish image
            AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView().frame(height: 200) // Loading indicator
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "photo") // Fallback image
                @unknown default:
                    EmptyView()
                }
            }.frame(height: 200)

            // Dish title
            Text(dish.title ?? "Unknown")
                .font(.largeTitle)
                .fontWeight(.bold)

            // Dish price
            Text("Price: $\(dish.price ?? "0.00")")
                .font(.headline)

            Spacer() // Push content up
        }
        .padding()
        .navigationTitle("Dish Details") // Navigation bar title
        .navigationBarTitleDisplayMode(.inline)
    }
}
