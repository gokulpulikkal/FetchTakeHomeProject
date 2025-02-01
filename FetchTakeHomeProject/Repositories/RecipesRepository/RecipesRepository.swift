//
//  RecipesRepository.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/30/25.
//

import Foundation
import NetworkLayer

final class RecipesRepository: RecipesRepositoryProtocol {

    let httpClient: HTTPClientProtocol

    init(httpClient: HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
    }

    func getRecipesList() async throws -> [Recipe] {
        let allRecipesRequestData = RecipesRepositoryRequests.allRecipes
        let data = try await httpClient.httpData(from: allRecipesRequestData)
        let recipesList = try JSONDecoder().decode(RecipesResponse.self, from: data)
        return recipesList.recipes
    }
}
