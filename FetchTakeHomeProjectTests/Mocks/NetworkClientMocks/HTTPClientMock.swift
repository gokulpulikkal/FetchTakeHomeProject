//
//  HTTPClientMock.swift
//  FetchTakeHomeProjectTests
//
//  Created by Gokul P on 1/30/25.
//

import Foundation
import NetworkLayer
@testable import FetchTakeHomeProject

/// Mock class to be used for mocking HTTP Client
/// Make sure that the access to the handler is thread safe as it is marked unchecked sendable
/// As this class is only used for testing and handler's main functionality is for unit testing  marking this as
/// unchecked sendable is fine.
final class HTTPClientMock: @unchecked Sendable, HTTPClientProtocol {

    var handler: (() -> Data)?

    func httpData(from requestData: any RequestDataProtocol) async throws -> Data {
        if let handler {
            return handler()
        } else {
            throw APIError.failedToGetResponse
        }
    }

}
