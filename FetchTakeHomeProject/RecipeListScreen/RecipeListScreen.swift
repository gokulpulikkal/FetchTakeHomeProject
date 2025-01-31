//
//  RecipeListScreen.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/30/25.
//

import SwiftUI

struct RecipeListScreen: View {

    @State var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.loadStatus {
                case .loading:
                    ProgressView()
                case let .loaded(recipes):
                    recipeListView(for: recipes)
                case .failed:
                    errorView
                }
            }
            .navigationTitle("Recipes")
            .task {
                await viewModel.loadRecipes()
            }
        }
    }
}

extension RecipeListScreen {
    // MARK: - sub views

    var errorView: some View {
        ContentUnavailableView(
            "No Recipes available",
            systemImage: "clock.badge.xmark",
            description: Text("The API returned an error!")
        )
    }

    @ViewBuilder
    private func recipeListView(for recipes: [Recipe]) -> some View {
        List {
            ForEach(recipes) { recipe in
                RecipeListItemView(recipe: recipe)
            }
        }
        .listStyle(.plain)
        .refreshable {
            await viewModel.refreshRecipes()
        }
    }
}

#Preview {
    RecipeListScreen()
}
