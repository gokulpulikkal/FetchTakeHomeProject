//
//  ImageGetterUseCase.swift
//  CustomUIs
//
//  Created by Gokul P on 3/6/25.
//

import Foundation
import SwiftUI

enum ImageGetterProgress {
    case loading(Task<UIImage, Error>)
    case complete(UIImage)
    case failed(Error)
}

actor ImageGetterUseCase: ImageGetterUseCaseProtocol {

    private var urlToProgressMap: [String: ImageGetterProgress] = [:]
    static let shared = ImageGetterUseCase()

    /// Image cache handler
    /// This will holds the caching related methods
    private let imageCache: ImageCacheProtocol

    /// Image downloader
    /// This handler will make sure that if the image is not available in the cache it is downloaded and saved to the
    /// cache
    private let imageDownloader: DownloaderProtocol

    // MARK: - Init
    
    init(
        imageCache: ImageCacheProtocol = ImageCache.shared,
        imageDownloader: DownloaderProtocol = FileDownloader()
    ) {
        self.imageCache = imageCache
        self.imageDownloader = imageDownloader
    }

    
    /// Function for getting the image from the cache and if it does not exist there, will download and update the cache
    /// - Parameter url: url string for getting the image
    /// - Returns: This function will return an image. If the there is an on going image download task, the function will make the caller await on the task value
    func getImage(for url: String?) async throws -> UIImage {
        guard let url, let urlObject = URL(string: url) else {
            throw DownloadErrors.invalidURL
        }
        
        // checking whether an ongoing task for image getter is there or not
        if let inProgressItem = urlToProgressMap[url] {
            switch inProgressItem {
            case let .complete(image):
                return image
            case let .loading(task):
                return try await task.value
            case let .failed(error):
                throw error
            }
        }

        let task = Task {
            if let image = await imageCache.getImage(forKey: url) {
                return image
            }
            let imageData = try await imageDownloader.download(urlObject)
            guard let uiImage = UIImage(data: imageData) else {
                throw DownloadErrors.downloadUnsuccessful
            }
            await imageCache.setImage(uiImage, forKey: urlObject.absoluteString)
            return uiImage
        }

        urlToProgressMap[url] = .loading(task)
        do {
            let image = try await task.value
            urlToProgressMap[url] = .complete(image)
            return image
        } catch {
            urlToProgressMap[url] = .failed(error)
            throw error
        }
    }
}
