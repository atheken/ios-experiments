//
//  MenuViewController.swift
//  CustomMenuSegue
//
//  Created by Andrew Theken on 6/28/15.
//  Copyright (c) 2015 attrio. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Cause this controller to present "custom", which is required to allow transitioning to be specified.
        self.modalPresentationStyle = .Custom
        // Allow this controller to specify its transitioning capabilities.
        self.transitioningDelegate = self
    }

    @IBAction func Dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    //MARK: Allow this controller to define how it's going to be animated. (UIViewControllerTransitioningDelegate)
    func animationControllerForPresentedController(presented: UIViewController,
        presentingController presenting: UIViewController,
        sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

    //MARK: Handle transition in or out. (UIViewControllerAnimatedTransitioning)

    private var presented = false

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
            let titlebarHeight = CGFloat(65.0)
            if(!presented){
                presented = true
                if let f = UIApplication.sharedApplication().keyWindow?.frame {
                    self.view.frame.offset(dx: f.width - (self.view.frame.width + 16.0), dy: -self.view.frame.height)
                    transitionContext.containerView().addSubview(self.view)
                    let timing = self.transitionDuration(transitionContext)

                    let l:(()->Void) = {
                        self.view.frame.offset(dx: 0, dy: (self.view.frame.height + titlebarHeight))
                    }
                    UIView.animateWithDuration(timing, animations: l) { b in transitionContext.completeTransition(true)}
                }
            }
            else {
                presented = false
                let timing = self.transitionDuration(transitionContext)
                let l:(()->Void) = {
                    self.view.frame.offset(dx: 0, dy: -(self.view.frame.height + titlebarHeight))
                }

                UIView.animateWithDuration(timing, animations: l) { b in
                    self.view.removeFromSuperview()
                    transitionContext.completeTransition(true)
                }
            }
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.25
    }


}
