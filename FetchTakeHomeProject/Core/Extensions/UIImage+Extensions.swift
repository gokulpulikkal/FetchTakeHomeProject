//
//  UIImage+Extensions.swift
//  FetchTakeHomeProject
//
//  Created by Gokul P on 2/1/25.
//

import Foundation
import UIKit

extension UIImage {

    /// Compares if two UIImages are equal or not
    /// Uses Data representation of UIImages
    func isDataEqual(to imageTwo: UIImage) -> Bool {
        if let selfData = pngData(), let imageTwoData = imageTwo.pngData() {
            let data1: NSData = selfData as NSData
            let data2: NSData = imageTwoData as NSData
            return data1.isEqual(data2)
        }
        return false
    }
}
