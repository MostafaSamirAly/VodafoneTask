//
//  LoadMoreTableViewCell.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 26/07/2021.
//

import UIKit

class LoadMoreTableViewCell: UITableViewCell {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        activityIndicator.startAnimating()
    }
    
}
