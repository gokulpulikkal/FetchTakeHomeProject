//
//  FileManagerInterfaceMock.swift
//  FetchTakeHomeProjectTests
//
//  Created by Gokul P on 2/1/25.
//

import Foundation
@testable import CustomUIs

actor FileManagerInterfaceMock: FileManagerProtocol {

    /// Handler helper for mocking the error cases
    /// Added purely for the testing purpose
    /// used when there is need throwing errors from file manager
    nonisolated(unsafe) var handler: (() throws -> Void)?

    /// mocking the file system cache
    var cache: [String: Data] = [:]

    func getData(forKey key: String) async throws -> Data {
        try handler?()
        if cache[key] != nil {
            return cache[key]!
        }
        throw FileManagerErrors.fileDoesNotExist
    }

    func setData(_ data: Data, forKey key: String) async throws {
        try handler?()
        cache[key] = data
    }

    func clearDirectory() async throws {
        try handler?()
        cache = [:]
    }

}
