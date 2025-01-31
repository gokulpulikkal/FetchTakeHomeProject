//
//  RecipeListScreen+ViewModelTests.swift
//  FetchTakeHomeProjectTests
//
//  Created by Gokul P on 1/31/25.
//

import Testing
@testable import FetchTakeHomeProject

@MainActor
struct RecipeListScreen_ViewModelTests {

    private let recipesRepository: RecipeRepositoryMock
    private let viewModel: RecipeListScreen.ViewModel
    let mockRecipesList = [
        Recipe(
            cuisine: "Italy",
            name: "Chicken",
            photoURLLarge: "",
            photoURLSmall: "",
            sourceURL: "",
            uuid: "123",
            youtubeURL: ""
        )
    ]

    init() {
        self.recipesRepository = RecipeRepositoryMock()
        self.viewModel = RecipeListScreen.ViewModel(recipesRepository: recipesRepository)
    }

    @Test
    func loadStatusSuccessfulUpdate() async throws {
        #expect(viewModel.loadStatus == .loading)
        recipesRepository.handler = {
            mockRecipesList
        }
        await viewModel.loadRecipes()
        #expect(viewModel.loadStatus == .loaded(mockRecipesList))
    }

    @Test
    func loadStatusUpdateWithFailedListFromRepository() async throws {
        #expect(viewModel.loadStatus == .loading)
        await viewModel.loadRecipes()
        #expect(viewModel.loadStatus != .loading && viewModel.loadStatus != .loaded([]))
    }

    @Test
    func loadStatusUpdateWithEmptyList() async throws {
        #expect(viewModel.loadStatus == .loading)
        recipesRepository.handler = {
            []
        }
        await viewModel.loadRecipes()
        #expect(viewModel.loadStatus == .loaded([]))
    }
    
    @Test func refreshListUpdateWithNewRecipesListFromRepository() async throws {
        try #require(viewModel.loadStatus == .loading)
        recipesRepository.handler = {
            []
        }
        await viewModel.loadRecipes()
        try #require(viewModel.loadStatus == .loaded([]))
        recipesRepository.handler = {
            mockRecipesList
        }
        await viewModel.refreshRecipes()
        #expect(viewModel.loadStatus == .loaded(mockRecipesList))
    }
}
