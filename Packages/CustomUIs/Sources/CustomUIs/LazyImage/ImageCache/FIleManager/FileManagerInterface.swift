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

    init(cacheDirectory: String = "ImageCache") {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        self.cacheDirectory = paths[0].appendingPathComponent(cacheDirectory)
    }

    // MARK: - Methods

    /// A function that will try to read data from the file system for the given key parameter
    /// The key is encoded before using as file name to search for. This is done as the key can be long or contains some
    /// characters not suited for using as file name
    func getData(forKey key: String) async throws -> Data {
        guard let safeFileName = key.data(using: .utf8)?.base64EncodedString() else {
            throw FileManagerErrors.fileReadFailed
        }

        let fileURL = cacheDirectory.appendingPathComponent(safeFileName)

        do {
            return try Data(contentsOf: fileURL)
        } catch {
            #if DEBUG
            print("Cache MISS: Failed to read data from file")
            #endif
            if (error as NSError).code == NSFileReadNoSuchFileError {
                throw FileManagerErrors.fileDoesNotExist
            } else {
                throw FileManagerErrors.fileReadFailed
            }
        }
    }

    /// A function that will try to writes data to the file system for the given key parameter
    /// The key is encoded before using as file name to write for. This is done as the key can be long or contains some
    /// characters not suited for using as file name
    func setData(_ data: Data, forKey key: String) async throws {
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            do {
                try fileManager.createDirectory(
                    at: cacheDirectory,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            } catch {
                throw FileManagerErrors.fileWriteFailed
            }
        }

        guard let safeFileName = key.data(using: .utf8)?.base64EncodedString() else {
            throw FileManagerErrors.fileWriteFailed
        }

        let fileURL = cacheDirectory.appendingPathComponent(safeFileName)

        do {
            try data.write(to: fileURL, options: .atomic)
        } catch {
            #if DEBUG
            print("Failed to write data to file: \(error)")
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
