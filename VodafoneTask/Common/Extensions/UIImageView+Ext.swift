//
//  UIImageView+Ext.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

import SDWebImage

extension UIImageView {
    func setImage(with url: String) {
        self.sd_cancelCurrentImageLoad()
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let transformer = SDImageResizingTransformer(size: CGSize(width: 400, height: 200), scaleMode: .aspectFill)
        self.sd_setImage(with: URL(string: url), placeholderImage: nil, options: [], context: [.imageTransformer:transformer])
    }
}
