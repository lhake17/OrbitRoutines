//
//  OrbitRoutinesApp.swift
//  OrbitRoutines
//
//  Created by Laurin Hake on 06.01.25.
//

import SwiftUI

@main
struct OrbitRoutinesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
