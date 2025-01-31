//
//  HomeScreen.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/30/25.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        Text("Hello, World!")
            .task {
                let apiClient = HTTPClient()
                let data = try? await apiClient.httpData(from: RecipeRequestData.allRecipes)
                print(data)
            }
    }

}

#Preview {
    HomeScreen()
}
