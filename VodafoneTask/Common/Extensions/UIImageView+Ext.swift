//
//  UIImageView+Ext.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

import SDWebImage

extension UIImageView {
    func setImage(with url: String) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let transformer = SDImageResizingTransformer(size: CGSize(width: 400, height: 200), scaleMode: .aspectFill)
        self.sd_setImage(with: URL(string: url), placeholderImage: nil, options: [], context: [.imageTransformer:transformer])
    }
    
    private func scaleImage(image:UIImage) -> UIImage? {

            let oldWidth = image.size.width
            let oldHeight = image.size.height

            var scaleFactor:CGFloat
            var newHeight:CGFloat
            var newWidth:CGFloat
            let viewWidth:CGFloat = self.frame.width

            if oldWidth > oldHeight {
                scaleFactor = oldHeight/oldWidth
                newHeight = viewWidth * scaleFactor
                newWidth = viewWidth
            } else {
                scaleFactor = oldHeight/oldWidth
                newHeight = viewWidth * scaleFactor
                newWidth = viewWidth
            }

            UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
            image.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
        }
}

