//
//  Menu.swift
//  Little Lemon
//
//  Created by Amine on 20/11/2024.
//

import SwiftUI

/// Shows the menu page with search feature and filtering feature for the dishes list
struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var hasLoadedData = false
    @State private var searchText: String = ""

    @State var startersIsEnabled = false
    @State var mainsIsEnabled = false
    @State var dessertsIsEnabled = false
    @State var drinksIsEnabled = false
    /// We will use this to show a fake load delay to simulate a realistic experience
    /// Normally in real world where we are not using CoreData, filters will directly communicate with API
    /// This means there will be a loading time delay until the API returns the new results
    @State private var isLoading = false

    @State var isKeyboardVisible = false

    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }

    var body: some View {
        VStack(spacing: 10) {
            VStack {
                if !isKeyboardVisible {
                    withAnimation {
                        Hero()
                            .frame(maxHeight: 180)
                    }
                }
                TextField("Search menu", text: $searchText)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            .background(AppColors.greenDark)

            Text("ORDER FOR DELIVERY!")
                .font(.sectionTitle())
                .foregroundColor(AppColors.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.leading)
                .bold()
            
            //Categories selector
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    Toggle(
                        "Starters",
                        isOn: Binding(
                            get: { startersIsEnabled },
                            set: { newValue in
                                if newValue {
                                    isLoading = true
                                    setExclusiveToggle(for: "starters")
                                }
                                startersIsEnabled = newValue
                            }
                        ))

                    Toggle(
                        "Mains",
                        isOn: Binding(
                            get: { mainsIsEnabled },
                            set: { newValue in
                                if newValue {
                                    isLoading = true
                                    setExclusiveToggle(for: "mains")
                                }
                                mainsIsEnabled = newValue
                            }
                        ))

                    Toggle(
                        "Desserts",
                        isOn: Binding(
                            get: { dessertsIsEnabled },
                            set: { newValue in
                                if newValue {
                                    isLoading = true
                                    setExclusiveToggle(for: "desserts")
                                }
                                dessertsIsEnabled = newValue
                            }
                        ))

                    Toggle(
                        "Drinks",
                        isOn: Binding(
                            get: { drinksIsEnabled },
                            set: { newValue in
                                if newValue {
                                    isLoading = true
                                    setExclusiveToggle(for: "drinks")
                                }
                                drinksIsEnabled = newValue
                            }
                        ))
                }
                .toggleStyle(AppToggleStyle())
                .padding(.horizontal)
            }

            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                if (isLoading){
                    ProgressView("Loading dishes...").padding().frame(height: 280)
                }else{
                List {
                    ForEach(dishes, id: \.self) { dish in
                        NavigationLink(destination: DishDetails(dish: dish)) {
                            DishCard(
                                title: dish.title ?? "",
                                description: dish.dishDescription ?? "",
                                price: dish.price ?? "0",
                                imageURL: dish.image ?? ""
                            )
                        }.navigationTitle("Menu")
                    }
                }.padding()
                    .listStyle(.plain)}
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            // Only load data if it is not there already
            if !hasLoadedData {
                getMenuData()  // Fetch menu data when the view appears
                hasLoadedData = true  // Set hasloaded data to true so it does not load it again when going back from dish details view
            }
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: UIResponder.keyboardWillShowNotification)
        ) { notification in
            withAnimation {
                self.isKeyboardVisible = true
            }

        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: UIResponder.keyboardWillHideNotification)
        ) { notification in
            withAnimation {
                self.isKeyboardVisible = false
            }
        }
    }
    func buildPredicate() -> NSPredicate {
        
        // Check if no filters are applied
        let noFilterApplied =
            searchText.isEmpty && !startersIsEnabled && !mainsIsEnabled
            && !dessertsIsEnabled && !drinksIsEnabled

        // Return all items if no filters are applied
        if noFilterApplied {
            return NSPredicate(value: true)
        }

        // Individual predicates for search and filters
        let searchPredicate: NSPredicate =
            searchText.isEmpty
            ? NSPredicate(value: true)
            : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let starters =
            startersIsEnabled
            ? NSPredicate(format: "category == %@", "starters")
            : NSPredicate(value: true)
        let mains =
            mainsIsEnabled
            ? NSPredicate(format: "category == %@", "mains")
            : NSPredicate(value: true)
        let desserts =
            dessertsIsEnabled
            ? NSPredicate(format: "category == %@", "desserts")
            : NSPredicate(value: true)
        let drinks =
            drinksIsEnabled
            ? NSPredicate(format: "category == %@", "drinks")
            : NSPredicate(value: true)
        
        // Combine all predicates
        let compoundPredicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                searchPredicate, starters, mains, desserts, drinks,
            ])
        
        // Simulate a delay (fake load)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // Set loading to false
                isLoading = false
            }
        
        return compoundPredicate
    }
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                key: "title", ascending: true,
                selector: #selector(NSString.localizedStandardCompare(_:)))
        ]
    }

    func setExclusiveToggle(for category: String) {
        // Reset all toggles
        startersIsEnabled = false
        mainsIsEnabled = false
        dessertsIsEnabled = false
        drinksIsEnabled = false

        // Enable only the selected toggle
        switch category {
        case "starters":
            startersIsEnabled = true
        case "mains":
            mainsIsEnabled = true
        case "desserts":
            dessertsIsEnabled = true
        case "drinks":
            drinksIsEnabled = true
        default:
            break
        }
    }
    // Method to fetch menu data
    func getMenuData() {
        // Clear the database before fetching new data
        PersistenceController.shared.clear()

        let serverURLString =
            "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        guard let url = URL(string: serverURLString) else {
            print("Invalid URL.")
            return
        }

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
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
                        let dish = Dish(context: viewContext)  // Create new Dish object
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        dish.category = menuItem.category
                        dish.dishDescription = menuItem.description
                    }

                    do {
                        try viewContext.save()  // Save to Core Data
                        print("Menu data saved successfully.")
                    } catch {
                        print(
                            "Failed to save menu data: \(error.localizedDescription)"
                        )
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
