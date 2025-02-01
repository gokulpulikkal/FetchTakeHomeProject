//
//  ImageCacheProtocol.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import Foundation
import UIKit

/// Image cache protocol that defines necessary function needed for an image cache
/// This should be accessible parallel from different threads, marking as sendable
public protocol ImageCacheProtocol: Sendable {

    /// Returns an image if that exists in the cache for the give key
    func getImage(forKey key: String) async -> UIImage?

    /// Sets an image to the cache for the given key
    func setImage(_ image: UIImage, forKey key: String) async

    /// Clears all the items in the cache
    func clearCache() async
}
