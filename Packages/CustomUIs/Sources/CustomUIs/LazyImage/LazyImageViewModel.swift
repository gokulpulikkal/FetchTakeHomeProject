//
//  LazyImageViewModel.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import Core
import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
/// View model class for the LazyImage view
/// This will load the image from the cache if available. otherwise load from the remote and save it to the cache
class LazyImageViewModel {

    // MARK: - properties

    /// load state of the Image
    var loadStatus: LoadStatus<UIImage, any Error> = .loading

    private let imageGetterUseCase: ImageGetterUseCaseProtocol

    // MARK: - Init

    init(
        imageGetterUseCase: ImageGetterUseCaseProtocol = ImageGetterUseCase.shared
    ) {
        self.imageGetterUseCase = imageGetterUseCase
    }

    func loadImage(url: String?) async {
        loadStatus = .loading
        do {
            let image = try await imageGetterUseCase.getImage(for: url)
            loadStatus = .loaded(image)
        } catch {
            loadStatus = .failed(DownloadErrors.invalidURL)
        }
    }
}
