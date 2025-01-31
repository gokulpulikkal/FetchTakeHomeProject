//
//  LazyImageViewModel.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import Foundation
import SwiftUI

@MainActor
class LazyImageViewModel: Sendable {

    var loadStatus: LoadStatus<Image, any Error> = .loading

    private let imageCache: ImageCacheProtocol
    private let imageDownloader: DownloaderProtocol

    init(imageCache: ImageCacheProtocol = ImageCache.shared, imageDownloader: DownloaderProtocol = FileDownloader()) {
        self.imageCache = imageCache
        self.imageDownloader = imageDownloader
    }

    func loadImage(url: String?) async {
        guard let url, let urlObject = URL(string: url) else {
            loadStatus = .failed(DownloadErrors.noResponse)
            return
        }
        Task.detached(priority: .background) { @Sendable [weak self] in
            // marking this as sendable. should make sure that the setting anything on the self properties happens
            // on the main actor
            if let image = await self?.imageCache.getImage(forKey: url) {
                await MainActor.run {
                    self?.loadStatus = .loaded(Image(uiImage: image))
                }
            } else {
                do {
                    let data = try await self?.imageDownloader.download(urlObject)
                    guard let imageData = data, let uiImage = UIImage(data: imageData) else {
                        await MainActor.run {
                            self?.loadStatus = .failed(DownloadErrors.noResponse)
                        }
                        return
                    }
                    await self?.imageCache.setImage(uiImage, forKey: url)
                    await MainActor.run {
                        self?.loadStatus = .failed(DownloadErrors.noResponse)
                    }
                }
            }
        }
    }
}
