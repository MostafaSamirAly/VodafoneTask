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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Use this Method to configure cell with photo data
    func configure(with photo:Photo) {
        photoImageView.setImage(with: photo.downloadUrl)
        authorNameLabel.text = photo.author
    }
}
