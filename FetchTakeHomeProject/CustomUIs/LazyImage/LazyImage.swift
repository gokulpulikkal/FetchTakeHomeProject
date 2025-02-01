//
//  LazyImage.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import Foundation
import SwiftUI

@MainActor
/// Lazy Image view that loads image when appeared on the screen
///   - Parameters:
///      - Content: The main viewBuilder closure that will get the Image object once loaded successfully
///      - Placeholder: View that is shown when the Image is being loaded or failed to load
struct LazyImage<Content: View, Placeholder: View>: View {

    // MARK: - Properties

    @State private var viewModel = LazyImageViewModel()
    let url: String?
    let content: (Image) -> Content
    let placeholder: () -> Placeholder

    // MARK: - Initialization

    init(
        url: String?,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }

    // MARK: - Body

    var body: some View {
        Group {
            switch viewModel.loadStatus {
            case .loading:
                placeholder()
            case let .loaded(image):
                content(Image(uiImage: image))
            case .failed:
                placeholder()
            }
        }
        .task {
            await viewModel.loadImage(url: url)
        }
    }
}
