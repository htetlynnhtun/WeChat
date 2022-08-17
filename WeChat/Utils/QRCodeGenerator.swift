//
//  QRCodeGenerator.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation
import UIKit
import CoreImage.CIFilterBuiltins

class QRCodeGenerator {
    private static let context = CIContext()
    private static let filter = CIFilter.qrCodeGenerator()
    
    static func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage()
    }
}
