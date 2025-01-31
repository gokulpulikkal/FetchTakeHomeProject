//
//  RecipesRepositoryProtocol.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/30/25.
//

import Foundation

protocol RecipesRepositoryProtocol: Sendable {
    func getRecipesList() async throws -> [Recipe]
}
