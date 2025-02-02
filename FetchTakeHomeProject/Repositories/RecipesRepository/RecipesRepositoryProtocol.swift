//
//  RecipesRepositoryProtocol.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/30/25.
//

import Foundation

/// A protocol that outlines the function needed in the recipes repository
protocol RecipesRepositoryProtocol: Sendable {

    /// A function to return the recipes available
    func getRecipesList() async throws -> [Recipe]
}
