//
//  RecipeListScreen+ViewModel.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import Core
import Foundation
import Observation
import SwiftUI

extension RecipeListScreen {

    @Observable
    @MainActor
    class ViewModel {

        // MARK: - Properties

        /// property to show the current load status of the view
        var loadStatus: LoadStatus<[Recipe], any Error> = .loading

        /// repository to get recipe related data
        var recipesRepository: RecipesRepositoryProtocol

        // MARK: - Init

        init(recipesRepository: RecipesRepositoryProtocol = RecipesRepository()) {
            self.recipesRepository = recipesRepository
        }

        // MARK: - Methods

        /// A function that will return list of recipes
        func loadRecipes() async {
            loadStatus = .loading
            do {
                let recipes = try await recipesRepository.getRecipesList()
                loadStatus = .loaded(recipes)
            } catch {
                loadStatus = .failed(error)
            }
        }

        /// Function that will refresh the recipes
        func refreshRecipes() async {
            do {
                let recipes = try await recipesRepository.getRecipesList()
                loadStatus = .loaded(recipes)
            } catch {
                loadStatus = .failed(error)
            }
        }

    }
}
