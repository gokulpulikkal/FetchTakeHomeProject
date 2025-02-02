//
//  RecipesRepository.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/30/25.
//

import Foundation
import NetworkLayer

/// A sendable final class that conforms to the recipes repository
/// This class will handle retrieving of the recipes from the end point with http client dependency
final class RecipesRepository: RecipesRepositoryProtocol {

    // MARK: - Properties

    /// httpClient dependency to retrieve recipes from the remote endpoint
    let httpClient: HTTPClientProtocol

    // MARK: - Init

    init(httpClient: HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
    }

    /// Function that will return the list of recipes available from the endpoint
    func getRecipesList() async throws -> [Recipe] {
        let allRecipesRequestData = RecipesRepositoryRequests.allRecipes
        let data = try await httpClient.httpData(from: allRecipesRequestData)
        let recipesList = try JSONDecoder().decode(RecipesResponse.self, from: data)
        return recipesList.recipes
    }
}
