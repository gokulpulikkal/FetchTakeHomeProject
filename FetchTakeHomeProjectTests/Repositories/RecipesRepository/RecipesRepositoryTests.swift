//
//  RecipesRepositoryTests.swift
//  FetchTakeHomeProjectTests
//
//  Created by Gokul P on 1/30/25.
//

import Foundation
import Testing
@testable import FetchTakeHomeProject

@MainActor
@Suite(.serialized) /// All the tests should be serialized as the handler is not thread safe
struct RecipesRepositoryTests {

    private let recipesRepository: RecipesRepositoryProtocol
    private let httpClientMock: HTTPClientMock

    init() {
        self.httpClientMock = HTTPClientMock()
        self.recipesRepository = RecipesRepository(httpClient: httpClientMock)
    }

    @Test
    func getRecipesListWithCorrectDataFromHTTPClient() async throws {
        let path = try #require(Bundle.main.path(forResource: "RecipesList", ofType: "json"), "Error in constructing the path to RecipesList json")
        let data = try #require(FileManager.default.contents(atPath: path), "Error in getting the file at the path")
        
        httpClientMock.handler = {
            return data
        }
        
        let expectedResponse = try JSONDecoder().decode(RecipesResponse.self, from: data)
        let recipesList = try await recipesRepository.getRecipesList()
        #expect(recipesList == expectedResponse.recipes)
    }
    
    @Test func getRecipesListWithMalformedDataFromHTTPClient() async throws {
        let path = try #require(Bundle.main.path(forResource: "RecipesListMalformed", ofType: "json"), "Error in constructing the path to RecipesListMalformed json")
        let data = try #require(FileManager.default.contents(atPath: path), "Error in getting the file at the path")
        
        httpClientMock.handler = {
            return data
        }
        
        await #expect(performing: {
            try await recipesRepository.getRecipesList()
        }, throws: { error in
            return true
        })
    }
    
    @Test func getRecipesListWithEmptyListFromHTTPClient() async throws {
        let path = try #require(Bundle.main.path(forResource: "RecipesListEmpty", ofType: "json"), "Error in constructing the path to RecipesListEmpty json")
        let data = try #require(FileManager.default.contents(atPath: path), "Error in getting the file at the path")
        
        httpClientMock.handler = {
            return data
        }
        let recipesList = try await recipesRepository.getRecipesList()
        #expect(recipesList.isEmpty)
    }

}
