//
//  FetchTakeHomeProjectApp.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/30/25.
//

import SwiftUI

@main
struct FetchTakeHomeProjectApp: App {

    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            RecipeListScreen()
                .onChange(of: scenePhase) { _, newPhase in
                    if newPhase == .background {
                        Task {
                            await ImageCache.shared.clearCache()
                        }
                    }
                }
        }
    }
}
