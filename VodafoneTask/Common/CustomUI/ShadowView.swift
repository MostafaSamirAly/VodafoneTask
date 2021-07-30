//
//  ShadowView.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

import UIKit


class ShadowCornerView: UIView {
    
    // MARK: - View Lifecycle

    @IBInspectable public var cornerRadius: CGFloat = 0

    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    private func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
    }
}
