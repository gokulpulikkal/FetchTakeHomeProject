//
//  ImageCache.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import Foundation
import UIKit

actor ImageCache: ImageCacheProtocol {

    static let shared = ImageCache()

    private let fileManager: FileManagerProtocol

    init(fileManager: FileManagerProtocol = FileManagerInterface.shared) {
        self.fileManager = fileManager
    }

    func getImage(forKey key: String) async -> UIImage? {
        if let data = try? await fileManager.getData(forKey: key), let image = UIImage(data: data) {
            return image
        }
        #if DEBUG
        print("!!!!!!!!!! Reading Image from the cache failed for \(key)")
        #endif
        return nil
    }

    func setImage(_ image: UIImage, forKey key: String) async {
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

    func clearCache() async {
        do {
            try await fileManager.clearDirectory()
        } catch {
            #if DEBUG
            print("Failed to clear cache: \(error)")
            #endif
        }
    }
}
