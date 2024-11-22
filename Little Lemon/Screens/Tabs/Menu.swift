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
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 10){
            Text("Little Lemon").font(.largeTitle)
            Text("Chicago").font(.headline)
            Text("This is a simple app to learn SwiftUI. it is about a restaurant called little lemon. we will be showing the menu and other stuff. We will be applying what we have learned")
                .font(.body)
                .multilineTextAlignment(.center)
            TextField("Search menu", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                ScrollView {
                            ForEach(dishes, id: \.self) { dish in
                                NavigationLink(destination: DishDetails(dish: dish)){
                                    DishCard(
                                        title: dish.title ?? "",
                                        description: dish.dishDescription ?? "",
                                        price: dish.price ?? "0",
                                        imageURL: dish.image ?? ""
                                    )
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
    func buildPredicate() -> NSPredicate {
        return searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[c] %@", searchText)
    }
     func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        ]
    }
    
    // Method to fetch menu data
    func getMenuData() {
        // Clear the database before fetching new data
        PersistenceController.shared.clear()
        
        let serverURLString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        guard let url = URL(string: serverURLString) else {
            print("Invalid URL.")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching menu data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let menuList = try decoder.decode(MenuList.self, from: data)
                
                // Perform Core Data operations on the main thread
                DispatchQueue.main.async {
                    for menuItem in menuList.menu {
                        let dish = Dish(context: viewContext) // Create new Dish object
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        dish.category = menuItem.category
                        dish.dishDescription = menuItem.description
                    }
                    
                    do {
                        try viewContext.save() // Save to Core Data
                        print("Menu data saved successfully.")
                    } catch {
                        print("Failed to save menu data: \(error.localizedDescription)")
                    }
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}

#Preview {
    Menu()
}
