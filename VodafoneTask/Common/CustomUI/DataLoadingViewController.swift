//
//  DataLoadingVC.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

import UIKit

class DataLoadingViewController: UIViewController {
    var containerView: UIView!
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        containerView.backgroundColor = .white
        containerView.alpha = 0.3
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .gray
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let _ = self.containerView {
                self.containerView.removeFromSuperview()
                self.containerView = nil
            }
        }
    }
}
