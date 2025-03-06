//
//  ImageGetterUseCaseProtocol.swift
//  CustomUIs
//
//  Created by Gokul P on 3/6/25.
//

import Foundation
import UIKit

protocol ImageGetterUseCaseProtocol: Sendable {
    func getImage(for url: String?) async throws -> UIImage
}
