//
//  FileManagerInterface.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 2/1/25.
//

import Foundation

/// An actor implementation of File manager protocol using OS file manager
actor FileManagerInterface: FileManagerProtocol {

    // MARK: - Properties

    /// OS File manager instance
    private let fileManager = FileManager.default

    /// Cache directory URL to which all the cached files are writing to
    private let cacheDirectory: URL

    // MARK: - Initializer

    init() {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        self.cacheDirectory = paths[0].appendingPathComponent("ImageCache")
    }

    // MARK: - Methods

    /// A function that will try to read data from the file system for the given key parameter
    /// The key is encoded before using as file name to search for. This is done as the key can be long or contains some
    /// characters not suited for using as file name
    func getData(forKey key: String) async throws -> Data {
        guard let safeFileName = key.data(using: .utf8)?.base64EncodedString() else {
            throw FileManagerErrors.fileReadFailed
        }

        let fileURL = URL(fileURLWithPath: safeFileName, relativeTo: cacheDirectory).appendingPathExtension(key)
        do {
            return try Data(contentsOf: fileURL)
        } catch {
            throw FileManagerErrors.fileDoesNotExist
        }
    }

    /// A function that will try to writes data to the file system for the given key parameter
    /// The key is encoded before using as file name to write for. This is done as the key can be long or contains some
    /// characters not suited for using as file name
    func setData(_ data: Data, forKey key: String) async throws {
        guard let safeFileName = key.data(using: .utf8)?.base64EncodedString() else {
            throw FileManagerErrors.fileWriteFailed
        }

        let fileURL = cacheDirectory.appendingPathComponent(safeFileName, isDirectory: false)
        do {
            try data.write(to: fileURL)
        } catch {
            #if DEBUG
            print("The image caching write failed \(error)")
            #endif
            throw FileManagerErrors.fileWriteFailed
        }
    }

    /// Clears the entire cache directory
    func clearDirectory() async throws {
        let fileURLs = try fileManager.contentsOfDirectory(
            at: cacheDirectory,
            includingPropertiesForKeys: nil,
            options: []
        )
        for fileURL in fileURLs {
            #if DEBUG
            print("Clearing \(fileURL)")
            #endif
            try FileManager.default.removeItem(at: fileURL)
        }
        #if DEBUG
        print("Cache cleared successfully.")
        #endif
    }
}
