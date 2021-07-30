//
//  InfoVC.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 26/07/2021.
//

import SDWebImage

class InfoVC: UIViewController {
    
    @IBOutlet private weak var photoImageView: UIImageView!
    var viewModel:MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        navigationItem.title = "Details Screen"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        photoImageView.removeObserver(self, forKeyPath: #keyPath(UIImageView.image))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let image = photoImageView.image {
            do {
                self.view.backgroundColor = try image.dominantColors().first
            } catch {
                showAlert(message: "Couldn't get dominant color")
            }
        }
    }
    
    func loadImage() {
        photoImageView.addObserver(self, forKeyPath: #keyPath(UIImageView.image), options: .new, context: nil)
        if let imageUrl = viewModel?.selectedPhoto?.downloadUrl {
            photoImageView.setImage(with: imageUrl)
        }
    }
}
