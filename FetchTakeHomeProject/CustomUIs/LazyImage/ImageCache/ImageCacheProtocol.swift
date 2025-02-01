//
//  ImageCacheProtocol.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import Foundation
import UIKit

protocol ImageCacheProtocol: Sendable {
    func getImage(forKey key: String) async -> UIImage?
    func setImage(_ image: UIImage, forKey key: String) async
    func clearCache() async
}
