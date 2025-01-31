//
//  DownloaderProtocol.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import Foundation

protocol DownloaderProtocol: Sendable {
    func download(_ url: URL) async throws -> Data
}
