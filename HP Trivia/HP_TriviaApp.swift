//
//  HP_TriviaApp.swift
//  HP Trivia
//
//  Created by Shreyas Sahoo on 17/04/24.
//

import SwiftUI

@main
struct HP_TriviaApp: App {
    @StateObject private var store = Store()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .task{
                    await store.loadProducts()
                }
        }
    }
}
