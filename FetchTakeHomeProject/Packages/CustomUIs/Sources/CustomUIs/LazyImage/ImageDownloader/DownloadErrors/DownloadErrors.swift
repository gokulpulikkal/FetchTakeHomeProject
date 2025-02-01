//
//  DownloadErrors.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import Foundation

/// A type that lists possible Download errors
enum DownloadErrors: Error {

    /// download was not successful
    case downloadUnsuccessful
    /// the provided url is not valid
    case invalidURL
    /// downloaded file couldn't decoded successfully
    case decodeError
}
