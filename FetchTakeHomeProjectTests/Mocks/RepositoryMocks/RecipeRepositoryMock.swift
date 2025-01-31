//
//  RecipeRepositoryMock.swift
//  FetchTakeHomeProjectTests
//
//  Created by Gokul P on 1/31/25.
//

import Foundation
@testable import FetchTakeHomeProject

/// Recipe repository mock. Only to be used in testing. It is marked unchecked sendable as the handler is not thread
/// safe
/// Make sure that tests using the same instance of this class run not parallel.
final class RecipeRepositoryMock: @unchecked Sendable, RecipesRepositoryProtocol {

    var handler: (() -> [Recipe])?

    func getRecipesList() async throws -> [Recipe] {
        if let handler {
            handler()
        } else {
            throw APIError.decode
        }
    }
}
