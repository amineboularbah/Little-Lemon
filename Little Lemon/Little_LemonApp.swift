//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by Amine on 20/11/2024.
//

import SwiftUI

@main
struct Little_LemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            OnBoarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
