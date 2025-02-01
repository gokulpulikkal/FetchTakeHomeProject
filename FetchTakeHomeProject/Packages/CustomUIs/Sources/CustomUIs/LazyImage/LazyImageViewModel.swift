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

    /// Image cache handler
    /// This will holds the caching related methods
    private let imageCache: ImageCacheProtocol

    /// Image downloader
    /// This handler will make sure that if the image is not available in the cache it is downloaded and saved to the
    /// cache
    private let imageDownloader: DownloaderProtocol

    // MARK: - Init

    init(imageCache: ImageCacheProtocol = ImageCache.shared, imageDownloader: DownloaderProtocol = FileDownloader()) {
        self.imageCache = imageCache
        self.imageDownloader = imageDownloader
    }

    /// Function to load an image give it's url string
    /// this will first check if the image is already available in the cache
    /// if not will call download methods to download save it to the cache
    func loadImage(url: String?) async {
        loadStatus = .loading
        guard let url, let urlObject = URL(string: url) else {
            loadStatus = .failed(DownloadErrors.invalidURL)
            return
        }

        if let image = await imageCache.getImage(forKey: url) {
            loadStatus = .loaded(image)
        } else {
            await downloadImageAndSaveToCache(urlObject: urlObject)
        }
    }

    /// downloads image with the given url object and saves it the cache
    /// it also updates the load status of the view
    private func downloadImageAndSaveToCache(urlObject: URL) async {
        do {
            let imageData = try await imageDownloader.download(urlObject)
            guard let uiImage = UIImage(data: imageData) else {
                loadStatus = .failed(DownloadErrors.decodeError)
                return
            }
            loadStatus = .loaded(uiImage)
            await imageCache.setImage(uiImage, forKey: urlObject.absoluteString)
        } catch {
            loadStatus = .failed(DownloadErrors.downloadUnsuccessful)
        }
    }
}
