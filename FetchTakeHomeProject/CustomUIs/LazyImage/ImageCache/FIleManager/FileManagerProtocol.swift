//
//  FileManagerProtocol.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 2/1/25.
//

import Foundation

protocol FileManagerProtocol: Sendable {
    func getData(forKey key: String) async throws -> Data
    func setData(_ data: Data, forKey key: String) async throws
    func clearDirectory() async throws
}
