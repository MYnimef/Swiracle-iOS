//
//  swiracleApp.swift
//  swiracle
//
//  Created by Ivan Markov on 03.11.2021.
//

import SwiftUI

@main
struct swiracleApp: App {
    let storage = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                                    storage.viewContext)
        }
    }
}
