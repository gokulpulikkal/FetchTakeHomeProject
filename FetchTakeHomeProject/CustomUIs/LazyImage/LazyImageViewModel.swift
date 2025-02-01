//
//  LazyImageViewModel.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import Foundation
import SwiftUI

@MainActor
class LazyImageViewModel {

    var loadStatus: LoadStatus<UIImage, any Error> = .loading

    private let imageCache: ImageCacheProtocol
    private let imageDownloader: DownloaderProtocol

    init(imageCache: ImageCacheProtocol = ImageCache.shared, imageDownloader: DownloaderProtocol = FileDownloader()) {
        self.imageCache = imageCache
        self.imageDownloader = imageDownloader
    }

    func loadImage(url: String?) async {
        loadStatus = .loading
        guard let url, let urlObject = URL(string: url) else {
            loadStatus = .failed(DownloadErrors.noResponse)
            return
        }

        if let image = await imageCache.getImage(forKey: url) {
            loadStatus = .loaded(image)
        } else {
            await downloadImageAndSaveToCache(urlObject: urlObject)
        }
    }

    private func downloadImageAndSaveToCache(urlObject: URL) async {
        do {
            let imageData = try await imageDownloader.download(urlObject)
            guard let uiImage = UIImage(data: imageData) else {
                loadStatus = .failed(DownloadErrors.noResponse)
                return
            }
            loadStatus = .loaded(uiImage)
            await imageCache.setImage(uiImage, forKey: urlObject.absoluteString)
        } catch {
            loadStatus = .failed(DownloadErrors.noResponse)
        }
    }
}
