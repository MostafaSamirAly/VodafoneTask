//
//  PhotoTableViewCell.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    /// Use this Method to configure cell with photo data
    /// - Parameter photo: photo to configure with
    func configure(with photo:Photo) {
        photoImageView.setImage(with: photo.downloadUrl)
        authorNameLabel.text = photo.author
    }
}
