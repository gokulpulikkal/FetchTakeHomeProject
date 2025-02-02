//
//  RecipesResponse.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/30/25.
//

import Foundation

/// Decodable model that represents the response from recipe API endpoint
struct RecipesResponse: Decodable, Equatable {
    let recipes: [Recipe]
}
