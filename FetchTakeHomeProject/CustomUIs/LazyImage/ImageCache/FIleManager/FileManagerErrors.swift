//
//  FileManagerErrors.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 2/1/25.
//

import Foundation

/// A type that specifies different errors that can be thrown by the file manager
enum FileManagerErrors: Error {

    /// Case when the file manager fails to create cache directory
    case cacheDirectoryCreationFailed

    /// When the file manager finds that the file that is being searched for does not exists
    case fileDoesNotExist

    /// When file write is getting failed
    case fileWriteFailed

    /// File manager returns an error when reading an existing file
    case fileReadFailed
}
