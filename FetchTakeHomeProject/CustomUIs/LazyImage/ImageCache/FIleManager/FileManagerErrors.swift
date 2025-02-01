//
//  FileManagerErrors.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 2/1/25.
//

import Foundation

enum FileManagerErrors: Error {
    case cacheDirectoryCreationFailed
    case fileDoesNotExist
    case fileWriteFailed
    case fileReadFailed
}
