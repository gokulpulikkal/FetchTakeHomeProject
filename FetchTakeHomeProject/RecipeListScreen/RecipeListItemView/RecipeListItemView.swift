//
//  RecipeListItemView.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import SwiftUI
import CustomUIs

@MainActor
/// A view that will be used as a single item in the list view that shows a list of recipes
struct RecipeListItemView: View {

    // MARK: Properties

    /// The recipe for which the view is showing details for
    let recipe: Recipe

    // MARK: Body

    var body: some View {
        HStack(spacing: 15) {
            recipeImageView
                .frame(width: 150, height: 150)
                .background(.thickMaterial)
            metaDataView
        }
        .frame(height: 160)
        .padding(.trailing)
    }
}

extension RecipeListItemView {

    // MARK: Sub View

    @ViewBuilder
    var recipeImageView: some View {
        if let url = recipe.photoURLSmall {
            LazyImage(
                url: url,
                content: { image in
                    image
                        .resizable()
                        .scaledToFit()
                },
                placeholder: {
                    ProgressView()
                }
            )
        } else {
            Image(systemName: "exclamationmark.triangle.fill")
        }
    }

    var metaDataView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text("Name:")
                    .font(.callout)
                Text(recipe.name)
                    .foregroundColor(.primary)
                    .font(.headline)
            }
            HStack(alignment: .top) {
                Text("Cuisine:")
                    .foregroundColor(.secondary)
                    .font(.callout)
                Text(recipe.cuisine)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    RecipeListItemView(recipe: .init(
        cuisine: "Kerala",
        name: "Puttu",
        photoURLLarge: nil,
        photoURLSmall: nil,
        sourceURL: nil,
        uuid: "142",
        youtubeURL: nil
    ))
}
