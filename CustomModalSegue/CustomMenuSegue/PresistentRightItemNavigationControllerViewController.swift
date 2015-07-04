//
//  PresistentRightItemNavigationControllerViewController.swift
//  CustomMenuSegue
//
//  Created by Andrew Theken on 6/29/15.
//  Copyright © 2015 attrio. All rights reserved.
//

import UIKit

class PresistentRightItemNavigationControllerViewController: UINavigationController {

    func setRightItem(viewController:UIViewController){
        let img = UIImage(named:"menu")
        let item = UIBarButtonItem(image: img, style: UIBarButtonItemStyle.Plain,
            target: self, action: Selector("showMenu:"))
        viewController.navigationItem.rightBarButtonItem = item
    }


    override func pushViewController(viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController,animated: animated)
        self.setNavigationBarHidden(false, animated: true)
        setRightItem(viewController)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setRightItem(self.visibleViewController)
    }

    @objc func showMenu(sender:AnyObject?){

        let menu = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MenuViewController") as! UIViewController

        self.presentViewController(menu, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
