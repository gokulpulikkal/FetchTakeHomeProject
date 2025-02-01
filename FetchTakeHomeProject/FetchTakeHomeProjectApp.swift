//
//  FetchTakeHomeProjectApp.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/30/25.
//

import CustomUIs
import SwiftUI

@main
struct FetchTakeHomeProjectApp: App {

    // MARK: - Properties

    /// Scene phase environment object for listening to the app lifecycle events
    /// Will use this for knowing if the app entered background or not
    @Environment(\.scenePhase) var scenePhase

    // MARK: - Body

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
