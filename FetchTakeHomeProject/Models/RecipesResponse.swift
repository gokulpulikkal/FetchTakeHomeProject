//
//  RecipesResponse.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/30/25.
//

import Foundation

struct RecipesResponse: Decodable, Equatable {
    let recipes: [Recipe]
}
