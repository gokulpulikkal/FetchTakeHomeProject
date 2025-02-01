//
//  FileDownloaderMock.swift
//  FetchTakeHomeProjectTests
//
//  Created by Gokul P on 1/31/25.
//

import Foundation
@testable import FetchTakeHomeProject

/// Marked unchecked sendable protocol for the purpose of mocking. now this is not thread safe. should only be used
/// synchronously
class FileDownloaderMock: @unchecked Sendable, DownloaderProtocol {

    /// Added purely for the testing purpose
    /// used when there is need of checking that the image is coming from downloader
    var handler: (() -> Data)?

    func download(_ url: URL) async throws -> Data {
        if let handler {
            return handler()
        } else {
            throw APIError.failedToGetResponse
        }
    }

}
