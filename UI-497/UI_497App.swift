//
//  UI_497App.swift
//  UI-497
//
//  Created by nyannyan0328 on 2022/03/07.
//

import SwiftUI

@main
struct UI_497App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
