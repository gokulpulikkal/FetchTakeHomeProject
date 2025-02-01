//
//  ImageCacheTests.swift
//  FetchTakeHomeProjectTests
//
//  Created by Gokul P on 2/1/25.
//

import Testing
import UIKit
@testable import CustomUIs

@Suite(.serialized)
struct ImageCacheTests {

    let imageCache: ImageCacheProtocol
    let fileManagerMock = FileManagerInterfaceMock()

    init() {
        self.imageCache = ImageCache(fileManager: fileManagerMock)
    }

    @Test
    func cacheMiss() async throws {
        let testURL = "https://example.com/image.png"
        let image = await imageCache.getImage(forKey: testURL)
        #expect(image == nil)
    }

    @Test
    func cacheHit() async throws {
        let testURL = "https://example.com/image.png"
        let expectedImage = UIImage(systemName: "star")!
        await imageCache.setImage(expectedImage, forKey: testURL)

        let returnedImage = try #require(await imageCache.getImage(forKey: testURL))
        #expect(returnedImage.isDataEqual(to: UIImage(data: expectedImage.pngData()!)!))
    }

    @Test
    func cacheReadAndFileManagerThrowsError() async throws {
        fileManagerMock.handler = {
            throw FileManagerErrors.fileDoesNotExist
        }
        let testURL = "https://example.com/image.png"
        let image = await imageCache.getImage(forKey: testURL)
        
        ///Even though the file manager is throwing error image cache should handle that and return a nil value
        #expect(image == nil)
    }
    
    @Test
    func cacheWriteAndFileManagerThrowsError() async throws {
        fileManagerMock.handler = {
            throw FileManagerErrors.fileWriteFailed
        }
        let testURL = "https://example.com/image.png"
        let testImage = UIImage(systemName: "star")!
        
        ///Even though the file manager is throwing error image cache should handle that and return a nil value
        await imageCache.setImage(testImage, forKey: testURL)
    }

}
