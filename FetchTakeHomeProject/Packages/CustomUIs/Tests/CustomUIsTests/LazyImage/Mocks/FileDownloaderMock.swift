//
//  FileDownloaderMock.swift
//  FetchTakeHomeProjectTests
//
//  Created by Gokul P on 1/31/25.
//

import Foundation
@testable import CustomUIs

/// Marked unchecked sendable protocol for the purpose of mocking. now this is not thread safe. should only be used
/// synchronously
actor FileDownloaderMock: DownloaderProtocol {

    /// Added purely for the testing purpose
    /// used when there is need of checking that the image is coming from downloader
    var handler: (() -> Data)?
    
    func setHandler(handlerImplementation: @escaping (() -> Data)) {
        self.handler = handlerImplementation
    }

    func download(_ url: URL) async throws -> Data {
        if let handler {
            return handler()
        } else {
            throw DownloadErrors.downloadUnsuccessful
        }
    }

}
