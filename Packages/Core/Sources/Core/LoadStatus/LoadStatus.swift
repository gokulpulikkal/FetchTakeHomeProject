//
//  LoadStatus.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import Foundation

public enum LoadStatus<Model: Equatable, Failure: Error> {

    case loading

    case loaded(Model)

    case failed(Failure)
}

// MARK: - Equatable

extension LoadStatus: Equatable {
    public static func == (lhs: LoadStatus<Model, Failure>, rhs: LoadStatus<Model, Failure>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            true
        case let (.loaded(l), .loaded(r)):
            l == r
        case let (.failed(eL), .failed(eR)):
            eL.localizedDescription == eR.localizedDescription
        default:
            false
        }
    }
}
