//
//  FileManagerProtocol.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 2/1/25.
//

import Foundation

/// A file manager protocol and it's needed functions
/// All the functions should throw a specific FileManagerErrors error for some reason the OS file manager throws an
/// error. An implementation for this should be thread safe so marking it as sendable
protocol FileManagerProtocol: Sendable {

    /// This will returns data if it exists in the file system with the key appended to cache directory
    func getData(forKey key: String) async throws -> Data

    /// Sets the data to the file system cache directory
    func setData(_ data: Data, forKey key: String) async throws

    /// Clears all the files written in the file system
    func clearDirectory() async throws
}
