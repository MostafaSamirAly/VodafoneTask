//
//  DataLoadingVC.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

import UIKit

class DataLoadingVC: UIViewController {
    var containerView:UIView!
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        containerView.backgroundColor = .white
        containerView.alpha = 0.3
        
        let activivtyIndicator = UIActivityIndicatorView(style: .medium)
        activivtyIndicator.color = .gray
        containerView.addSubview(activivtyIndicator)
        
        activivtyIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activivtyIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activivtyIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activivtyIndicator.startAnimating()
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let _ = self.containerView {
                self.containerView.removeFromSuperview()
                self.containerView = nil
            }
        }
    }
}
