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
        let height = UIApplication.sharedApplication().keyWindow?.frame.height ?? 0.0

        UIView.animateWithDuration(timing){

            var newSize = max(self.gestureStartHeight - change, self.startingSize)
            newSize = self.startingSize == self.gestureStartHeight ?  min(height, newSize) : newSize
            self.modalHeightConstraint.constant = newSize

            self.toolbarToBottom.constant = -self.toolbarHeightConstraint.constant * (newSize/height)

            if sender.state == .Ended {
                let ease:CGFloat = 70.0
                let startedFullScreen = self.gestureStartHeight != self.startingSize

                if  ((startedFullScreen && change >= ease) || (newSize <= (self.startingSize + ease))) {
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

