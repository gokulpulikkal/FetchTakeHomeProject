//
//  DownloadStatus.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 1/31/25.
//

import Foundation

enum DownloadStatus {
    case downloading(Float)
    case finished(Data)
}
