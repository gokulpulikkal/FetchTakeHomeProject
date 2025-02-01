//
//  ImageCacheMock.swift
//  FetchTakeHomeProjectTests
//
//  Created by Gokul P on 1/31/25.
//

import Foundation
import UIKit
@testable import CustomUIs

actor ImageCacheMock: ImageCacheProtocol {

    private var cache: [String: UIImage] = [:]

    /// Added purely for the testing purpose
    /// used when there is need of checking that the image is coming from cache

    func getImage(forKey key: String) async -> UIImage? {
        return cache[key]
    }

    func setImage(_ image: UIImage, forKey key: String) async {
        cache[key] = image
    }

    func clearCache() async {
        cache = [:]
    }
}
