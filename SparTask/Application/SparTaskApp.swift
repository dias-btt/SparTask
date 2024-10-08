//
//  SparTaskApp.swift
//  SparTask
//
//  Created by Диас Сайынов on 07.08.2024.
//

import SwiftUI
import SwiftData

@main
struct SparTaskApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SavedProduct.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainTabBarView()
        }
        .modelContainer(sharedModelContainer)
    }
}
