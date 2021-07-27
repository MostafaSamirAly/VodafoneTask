//
//  InfoVC.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 26/07/2021.
//

import SDWebImage

class InfoVC: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    let viewmodel = InfoViewmodel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupImage()
        navigationItem.title = "Details Screen"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        photoImageView.removeObserver(self, forKeyPath: #keyPath(UIImageView.image))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        do {
            self.view.backgroundColor = try photoImageView.image?.dominantColors().first
        } catch {
            showAlert(message: "Couldn't get dominent color")
        }
        
    }
    
    func setupImage() {
        photoImageView.addObserver(self, forKeyPath: #keyPath(UIImageView.image), options: .new, context: nil)
        if let imageUrl = viewmodel.photo?.downloadUrl {
            photoImageView.setImage(with: imageUrl)
        }
    }
}
