//
//  LazyImageViewModelTests.swift
//  FetchTakeHomeProjectTests
//
//  Created by Gokul P on 1/31/25.
//

import SwiftUI
import UIKit
import XCTest
@testable import FetchTakeHomeProject

@MainActor
final class LazyImageViewModelTests: XCTestCase {

    var imageCache: ImageCacheMock!
    var fileDownloader: FileDownloaderMock!
    var viewModel: LazyImageViewModel!

    override func setUp() {
        super.setUp()
        imageCache = ImageCacheMock()
        fileDownloader = FileDownloaderMock()
        viewModel = LazyImageViewModel(imageCache: imageCache, imageDownloader: fileDownloader)
    }

    override func tearDown() {
        viewModel = nil
        imageCache = nil
        fileDownloader = nil
        super.tearDown()
    }

    

    func testImageLoadingFirstTime() async throws {
        XCTAssert(viewModel.loadStatus == .loading)
        let testURL = "https://example.com/image.png"
        let testUIImage = UIImage(systemName: "star")!
        let testImageData = testUIImage.pngData()!

        let expectation = XCTestExpectation(description: "Wait for data to be loaded with HTTP client")
        fileDownloader.handler = {
            defer {
                expectation.fulfill()
            }
            return testImageData
        }
        await viewModel.loadImage(url: testURL)
        await fulfillment(of: [expectation], timeout: 2.0)

        if case let .loaded(loadedUIImage) = viewModel.loadStatus {
            XCTAssertTrue(loadedUIImage.isDataEqual(to: UIImage(data: testImageData)!))
        } else {
            XCTFail("Expected loaded status with image")
        }
    }
    
    func testImageLoadingFromCache() async throws {
        XCTAssert(viewModel.loadStatus == .loading)
        let testURL = "https://example.com/image.png"
        let testUIImage = UIImage(systemName: "star")!
        let testImageData = testUIImage.pngData()!

        fileDownloader.handler = {
            return testImageData
        }
        await viewModel.loadImage(url: testURL)

        if case let .loaded(loadedUIImage) = viewModel.loadStatus {
            XCTAssertTrue(loadedUIImage.isDataEqual(to: UIImage(data: testImageData)!))
        } else {
            XCTFail("Expected loaded status with image")
        }
        let expectation = XCTestExpectation(description: "Image is being taken from the cache")
        imageCache.handler = {
            expectation.fulfill()
        }
        
        await viewModel.loadImage(url: testURL)
        await fulfillment(of: [expectation])
        if case let .loaded(loadedUIImage) = viewModel.loadStatus {
            XCTAssertTrue(loadedUIImage.isDataEqual(to: UIImage(data: testImageData)!))
            
        } else {
            XCTFail("Expected loaded status with image")
        }
        
    }
    
    func testImageLoadingError() async throws {
        XCTAssert(viewModel.loadStatus == .loading)
        let testURL = "https://example.com/image.png"
        
        await viewModel.loadImage(url: testURL)
        
        if case let .failed(errorThrown) = viewModel.loadStatus {
            XCTAssertTrue(errorThrown as? DownloadErrors == DownloadErrors.downloadUnsuccessful)
        } else {
            XCTFail("Expected loaded status with image")
        }
    }
    

}
