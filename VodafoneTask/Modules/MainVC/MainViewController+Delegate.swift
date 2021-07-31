//
//  MainViewController+Delegate.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 31/07/2021.
//


extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController, source: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
        guard
          let selectedIndexPathCell = photosTableView.indexPathForSelectedRow,
          let selectedCell = photosTableView.cellForRow(at: selectedIndexPathCell)
            as? PhotoTableViewCell,
          let selectedCellSuperview = selectedCell.superview
          else {
            return nil
        }

        transition.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
        transition.originFrame = CGRect(
          x: transition.originFrame.origin.x + 20,
          y: transition.originFrame.origin.y + 20,
          width: transition.originFrame.size.width - 40,
          height: transition.originFrame.size.height - 40
        )

        transition.presenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
        return nil
    }

}
