//
//  LazyImageViewModelTest.swift
//  CustomUIs
//
//  Created by Gokul P on 2/1/25.
//

import Core
import SwiftUI
import Testing
import UIKit
@testable import CustomUIs

@MainActor
struct LazyImageViewModelTest {

    var imageCache: ImageCacheMock
    var fileDownloader: FileDownloaderMock
    var viewModel: LazyImageViewModel
    var imageGetterUseCase: ImageGetterUseCaseProtocol

    init() {
        self.imageCache = ImageCacheMock()
        self.fileDownloader = FileDownloaderMock()
        self.imageGetterUseCase = ImageGetterUseCase(imageCache: imageCache, imageDownloader: fileDownloader)
        self.viewModel = LazyImageViewModel(imageGetterUseCase: imageGetterUseCase)
    }

    @Test
    func ImageLoadingFirstTime() async throws {
        #expect(viewModel.loadStatus == .loading)
        let testURL = "https://example.com/image.png"
        let testUIImage = UIImage(systemName: "star")!
        let testImageData = testUIImage.pngData()!

        await fileDownloader.setHandler(handlerImplementation: { @Sendable in
            testImageData
        })
        await viewModel.loadImage(url: testURL)
        if case let .loaded(loadedUIImage) = viewModel.loadStatus {
            #expect(loadedUIImage.isDataEqual(to: UIImage(data: testImageData)!))
        }
    }

    @Test
    func testImageLoadingFromCache() async throws {
        #expect(viewModel.loadStatus == .loading)
        let testURL = "https://example.com/image.png"
        let testUIImage = UIImage(systemName: "star")!
        let testImageData = testUIImage.pngData()!

        await fileDownloader.setHandler(handlerImplementation: { @Sendable in
            testImageData
        })
        await viewModel.loadImage(url: testURL)

        if case let .loaded(loadedUIImage) = viewModel.loadStatus {
            #expect(loadedUIImage.isDataEqual(to: UIImage(data: testImageData)!))
        }

        await fileDownloader.setHandler(handlerImplementation: { @Sendable in
            Data() // Some data // Just make sure that the data is not coming from file downloader but from image cache
        })

        await viewModel.loadImage(url: testURL)
        if case let .loaded(loadedUIImage) = viewModel.loadStatus {
            #expect(loadedUIImage.isDataEqual(to: UIImage(data: testImageData)!))
        }
    }

    @Test
    func testImageLoadingError() async throws {
        #expect(viewModel.loadStatus == .loading)
        let testURL = "https://example.com/image.png"

        await viewModel.loadImage(url: testURL)
        
        var expectedError: DownloadErrors? = nil
        if case let .failed(errorThrown) = viewModel.loadStatus {
            expectedError = errorThrown as? DownloadErrors
        }
        #expect(expectedError != nil)
    }

}
