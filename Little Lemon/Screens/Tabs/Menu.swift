//
//  Menu.swift
//  Little Lemon
//
//  Created by Amine on 20/11/2024.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var hasLoadedData = false
    var body: some View {
        VStack(spacing: 10){
            Text("Little Lemon").font(.largeTitle)
            Text("Chicago").font(.headline)
            Text("This is a simple app to learn SwiftUI. it is about a restaurant called little lemon. we will be showing the menu and other stuff. We will be applying what we have learned")
                .font(.body)
                .multilineTextAlignment(.center)
            
            FetchedObjects(predicate: NSPredicate(value: true), sortDescriptors: []) { (dishes: [Dish]) in
                        List {
                            ForEach(dishes, id: \.self) { dish in
                                NavigationLink(destination: DishDetails(dish: dish)){
                                    HStack {
                                        AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 50, height: 50)
                                                    .clipShape(Circle())
                                            case .failure:
                                                Image(systemName: "photo")
                                            @unknown default:
                                                EmptyView().frame(width: 50, height: 50)
                                            }
                                        }
                                        Text("\(dish.title ?? "")")
                                        Spacer()
                                        Text("$\(dish.price ?? "")")
                                       
                                        
                                    }
                                }.navigationTitle("Menu")
                            }
                        }
                    }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding()
            .onAppear {
                // Only load data if it is not there already
                if(!hasLoadedData){
                    getMenuData() // Fetch menu data when the view appears
                    hasLoadedData = true // Set hasloaded data to true so it does not load it again when going back from dish details view
                }
            }
    }
    
    
    
    // Method to fetch menu data
    func getMenuData() {
        // Clear the database before fetching new data
        PersistenceController.shared.clear()
        
        let serverURLString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json" // Replace with actual URL
        guard let url = URL(string: serverURLString) else { return }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let menuList = try? decoder.decode(MenuList.self, from: data) {
                    for menuItem in menuList.menu {
                        let dish = Dish(context: viewContext) // Create new Dish object
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                    }
                    try? viewContext.save() // Save to Core Data
                } else {
                    print("Failed to decode JSON.")
                }
            } else if let error = error {
                print("Error fetching menu data: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}

#Preview {
    Menu()
}
