//
//  UIImageExtensions.swift
//  ColorKit
//
//  Created by Boris Emorine on 5/30/20.
//  Copyright © 2020 BorisEmorine. All rights reserved.
//

import UIKit

extension UIImage {
    
    enum ImageColorError: Error {
        /// The `CIImage` instance could not be created.
        case ciImageFailure
        
        /// The `CGImage` instance could not be created.
        case cgImageFailure
        
        /// Failed to get the pixel data from the `CGImage` instance.
        case cgImageDataFailure
        
        /// An error happened during the creation of the image after applying the filter.
        case outputImageFailure
        
        var localizedDescription: String {
            switch self {
            case .ciImageFailure:
                return "Failed to get a `CIImage` instance."
            case .cgImageFailure:
                return "Failed to get a `CGImage` instance."
            case .cgImageDataFailure:
                return "Failed to get image data."
            case .outputImageFailure:
                return "Could not get the output image from the filter."
            }
        }
    }
    
    var resolution: CGSize {
        return CGSize(width: size.width * scale, height: size.height * scale)
    }
    
    func resize(to targetSize: CGSize) -> UIImage {
        guard targetSize != resolution else {
            return self
        }
                
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.opaque = true
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        let resizedImage = renderer.image { _ in
            self.draw(in: CGRect(origin: CGPoint.zero, size: targetSize))
        }
        
        return resizedImage
    }
    
}
