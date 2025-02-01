//
//  FileManagerInterface.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 2/1/25.
//

import Foundation

actor FileManagerInterface: FileManagerProtocol {

    static let shared = FileManagerInterface()

    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    private init() {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        self.cacheDirectory = paths[0].appendingPathComponent("ImageCache")
    }

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
