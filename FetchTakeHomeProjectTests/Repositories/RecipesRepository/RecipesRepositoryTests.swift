//
//  RecipesRepositoryTests.swift
//  FetchTakeHomeProjectTests
//
//  Created by Gokul P on 1/30/25.
//

import Foundation
import Testing
@testable import FetchTakeHomeProject

struct RecipesRepositoryTests {

    private let recipesRepository: RecipesRepositoryProtocol
    private let httpClientMock: HTTPClientProtocol

    init() {
        self.httpClientMock = HTTPClientMock()
        self.recipesRepository = RecipesRepository(httpClient: httpClientMock)
    }

    @Test
    func getRecipesListWithCorrectDataFromHTTPClient() async throws {
        let path = try #require(Bundle.main.path(forResource: "RecipesList", ofType: "json"), "Error in constructing the path to RecipesList json")
        let data = try #require(FileManager.default.contents(atPath: path), "Error in getting the file at the path")
        
        
    }

}
