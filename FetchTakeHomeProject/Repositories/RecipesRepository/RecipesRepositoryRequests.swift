//
//  RecipesRepositoryRequests.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/30/25.
//

import Foundation
import NetworkLayer

/// A type that specifies all the needed fields for URL request creation for the Recipes end point API call
enum RecipesRepositoryRequests: RequestDataProtocol {

    /// for the end point where all recipes is returned from the API
    case allRecipes

    var method: RequestMethod {
        switch self {
        case .allRecipes:
            .get
        }
    }

    var endPoint: String {
        switch self {
        case .allRecipes:
            "/recipes.json"
        }
    }

    var host: String {
        switch self {
        case .allRecipes:
            "d3jbb8n5wk0qxi.cloudfront.net"
        }
    }
}
