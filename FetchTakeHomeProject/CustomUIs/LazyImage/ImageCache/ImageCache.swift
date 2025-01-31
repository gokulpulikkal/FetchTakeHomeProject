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

    private let cache = NSCache<NSString, UIImage>()
    private init() {}

    func getImage(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }

    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
