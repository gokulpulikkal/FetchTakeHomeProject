//
//  FileDownloader.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import Foundation

final class FileDownloader: DownloaderProtocol {

    /// URL session to be used for the API call
    private let session: URLSession

    // MARK: Initializer

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: - Methods

    func download(_ url: URL) async throws -> Data {
        guard let (data, response) = try await session.data(from: url) as? (Data, HTTPURLResponse) else {
            throw DownloadErrors.noResponse
        }
        return data
    }
}
