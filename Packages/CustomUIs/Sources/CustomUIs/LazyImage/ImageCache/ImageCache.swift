//
//  ImageCache.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import Foundation
import UIKit

/// A Image cache implementation using File systems
/// It's an actor so ensures the thread safe access
/// Also it is implemented as a singleton so only one instance exists throughout the entire app
public actor ImageCache: ImageCacheProtocol {

    // MARK: -  properties

    /// singleton instance accessor
    public static let shared = ImageCache()

    /// A file system instance. This can be used for writing and reading from the file system
    private let fileManager: FileManagerProtocol

    // MARK: - Initializer

    init(fileManager: FileManagerProtocol = FileManagerInterface()) {
        self.fileManager = fileManager
    }

    // MARK: - Methods

    /// A function that read the cache for the parameter key
    /// - Parameters:
    ///     - key: A string for which the cache has to be searched for
    ///  - Returns:
    ///     - UIImage if the image data is found in the cache
    public func getImage(forKey key: String) async -> UIImage? {
        do {
            let data = try await fileManager.getData(forKey: key)
            if let image = UIImage(data: data) {
                return image
            }
        } catch {
            #if DEBUG
            print("Image does not exists in cache")
            #endif
        }
        return nil
    }

    /// A function that save the image with the parameter key
    /// - Parameters:
    ///     - image: An image to save in the cache
    ///     - key: A string for which the image has to saved in the cache
    public func setImage(_ image: UIImage, forKey key: String) async {
        if let data = image.pngData() {
            do {
                try await fileManager.setData(data, forKey: key)
            } catch {
                #if DEBUG
                print("Saving Image to the cache failed \(error)")
                #endif
            }
        }
    }

    /// A function that will clear all the data in the cache
    public func clearCache() async {
        do {
            try await fileManager.clearDirectory()
        } catch {
            #if DEBUG
            print("Failed to clear cache: \(error)")
            #endif
        }
    }
}
