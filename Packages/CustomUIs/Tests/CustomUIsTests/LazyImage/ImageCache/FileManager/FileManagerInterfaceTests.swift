//
//  FileManagerInterfaceTests.swift
//  CustomUIs
//
//  Created by Gokul P on 2/1/25.
//

import Testing
@testable import CustomUIs

struct FileManagerInterfaceTests {

    let fileManagerInterface: FileManagerProtocol = FileManagerInterface(cacheDirectory: "TestDirectory")
    
    func clearTheTestDirectoryIfExists() async {
        do {
            try await fileManagerInterface.clearDirectory()
        } catch {
            print("No directory to clear")
        }
    }

    @Test
    func writeAndGetDataSuccess() async throws {
        await clearTheTestDirectoryIfExists()
        let key = "testKey"
        let testData = "testData".data(using: .utf8)!

        try await fileManagerInterface.setData(testData, forKey: key)

        let retrievedData = try await fileManagerInterface.getData(forKey: key)

        #expect(retrievedData == testData)
    }
    
    @Test
    func getDataForNonExistentKey() async throws {
        await clearTheTestDirectoryIfExists()
        let key = "testKey"

        await #expect(throws: FileManagerErrors.fileDoesNotExist) {
            try await fileManagerInterface.getData(forKey: key)
          }
    }
    
    @Test func clearCacheDirectory() async throws {
        let key = "testKey"
        let testData = "testData".data(using: .utf8)!
        try await fileManagerInterface.setData(testData, forKey: key)
        
        let key2 = "testKey23"
        let testData2 = "testData232".data(using: .utf8)!
        try await fileManagerInterface.setData(testData2, forKey: key2)
        
        try await fileManagerInterface.clearDirectory()
        
        await #expect(throws: FileManagerErrors.fileDoesNotExist) {
            try await fileManagerInterface.getData(forKey: key)
          }
        
        await #expect(throws: FileManagerErrors.fileDoesNotExist) {
            try await fileManagerInterface.getData(forKey: key2)
          }
    }

}
