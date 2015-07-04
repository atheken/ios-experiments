//
//  ViewController.swift
//  SlideInModal
//
//  Created by Andrew Theken on 7/3/15.
//  Copyright (c) 2015 attrio. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.startingSize = self.modalHeightConstraint.constant
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.apple.com/music")!))
    }
    
    @IBOutlet weak var toolbarHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var modalHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var toolbarToBottom: NSLayoutConstraint!

    private var fullscreen = false
    private var startingSize:CGFloat = 0.0
    private var gestureStartHeight:CGFloat = 0.0

    @IBAction func pull(sender: UIPanGestureRecognizer) {
        //need to have some gaurds and handle pushing
        //the toolbar down, but this is the basic premise.
        let change:CGFloat = sender.translationInView(view).y
        if sender.state == .Began {
            self.gestureStartHeight = self.modalHeightConstraint.constant
        }

        let timing = sender.state == .Ended ? 0.25 : 0.01
        let height = self.view.frame.height

        UIView.animateWithDuration(timing){

            let newSize = min(height,
                max(self.gestureStartHeight - change - self.toolbarToBottom.constant, self.startingSize))

            self.modalHeightConstraint.constant = newSize

            self.toolbarToBottom.constant = -self.toolbarHeightConstraint.constant * (newSize/height)

            if sender.state == .Ended {
                if self.gestureStartHeight != self.startingSize || newSize == self.startingSize {
                    self.modalHeightConstraint.constant = self.startingSize
                    self.toolbarToBottom.constant = 0.0
                }else{
                    self.modalHeightConstraint.constant = height + self.startingSize
                    self.toolbarToBottom.constant = -self.toolbarHeightConstraint.constant
                }
            }

            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }

}

