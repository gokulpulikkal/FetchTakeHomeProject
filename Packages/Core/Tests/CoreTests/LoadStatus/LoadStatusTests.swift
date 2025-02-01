//
//  LoadStatusTests.swift
//  Core
//
//  Created by Gokul P on 2/1/25.
//

import Testing
@testable import Core

struct LoadStatusTests {

    @Test
    func loadStatusEquality() async throws {
        let lhs = LoadStatus<Int, any Error>.loading
        let rhs = LoadStatus<Int, any Error>.loading
        #expect(lhs == rhs)
    }

    @Test
    func loadStatusNotEqual() async throws {
        let lhs = LoadStatus<Int, any Error>.loading
        let rhs = LoadStatus<Int, any Error>.loaded(42)
        #expect(lhs != rhs)
    }

    @Test
    func loadStatusLoadedWithSameValues() async throws {
        let lhs = LoadStatus<Int, any Error>.loaded(42)
        let rhs = LoadStatus<Int, any Error>.loaded(42)
        #expect(lhs == rhs)
    }

    @Test
    func loadStatusLoadedWithDifferentValues() async throws {
        let lhs = LoadStatus<Float, any Error>.loaded(42)
        let rhs = LoadStatus<Float, any Error>.loaded(43)
        #expect(lhs != rhs)
    }

    enum TestError: Error {
        case someError
        case anotherError
    }

    @Test
    func loadStatusUpdateWithSameError() async throws {
        let lhs = LoadStatus<Float, any Error>.failed(TestError.someError)
        let rhs = LoadStatus<Float, any Error>.failed(TestError.someError)
        #expect(lhs == rhs)
    }
    
    @Test
    func loadStatusUpdateWithDifferentError() async throws {
        let lhs = LoadStatus<Float, any Error>.failed(TestError.someError)
        let rhs = LoadStatus<Float, any Error>.failed(TestError.anotherError)
        #expect(lhs != rhs)
    }
}
