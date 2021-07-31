//
//  PopAnimator.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 31/07/2021.
//

import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.8
    var presenting = true
    var originFrame = CGRect.zero
    
    var dismissCompletion: (() -> Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
        guard let infoView = presenting ? toView : transitionContext.view(forKey: .from) else { return }
        
        let initialFrame = presenting ? originFrame : infoView.frame
        let finalFrame = presenting ? infoView.frame : originFrame

        let xScaleFactor = presenting ?
          initialFrame.width / finalFrame.width :
          finalFrame.width / initialFrame.width

        let yScaleFactor = presenting ?
          initialFrame.height / finalFrame.height :
          finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)

        if presenting {
            infoView.transform = scaleTransform
            infoView.center = CGPoint(
            x: initialFrame.midX,
            y: initialFrame.midY)
            infoView.clipsToBounds = true
        }

        infoView.layer.cornerRadius = presenting ? 20.0 : 0.0
        infoView.layer.masksToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(infoView)

        UIView.animate(
          withDuration: duration,
          delay:0.0,
          usingSpringWithDamping: 0.5,
          initialSpringVelocity: 0.2,
          animations: {
            infoView.transform = self.presenting ? .identity : scaleTransform
            infoView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            infoView.layer.cornerRadius = !self.presenting ? 20.0 : 0.0
          }, completion: { _ in
            if !self.presenting {
              self.dismissCompletion?()
            }
            transitionContext.completeTransition(true)
        })

    }
}

