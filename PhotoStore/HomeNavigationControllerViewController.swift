//
//  HomeNavigationControllerViewController.swift
//  PhotoStore
//
//  Created by Huijie Wu on 10/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit

class HomeNavigationControllerViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.translucent = true
        navigationBar.backgroundColor = UIColor.clearColor()
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return (UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Phone)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return .None
    }
}
