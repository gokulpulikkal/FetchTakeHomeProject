//
//  HTTPClientMock.swift
//  FetchTakeHomeProjectTests
//
//  Created by Gokul P on 1/30/25.
//

import Foundation
@testable import FetchTakeHomeProject

class HTTPClientMock: HTTPClientProtocol {

    var handler: (() -> Data)?

    func httpData(from requestData: any RequestDataProtocol) async throws -> Data {
        if let handler {
            return handler()
        } else {
            throw APIError.failedToGetResponse
        }
    }

}
