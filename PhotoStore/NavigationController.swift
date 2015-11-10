//
//  NavigationController.swift
//  PhotoStore
//
//  Created by Huijie Wu on 10/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func gotoHome() {
        let storyboard = UIStoryboard(name: "Home", bundle: NSBundle.mainBundle())
        if let homeViewController = storyboard.instantiateInitialViewController() {
            if let window = UIApplication.sharedApplication().delegate?.window {
                // change root view controller
                window?.rootViewController = homeViewController
                // animate
                UIView.transitionWithView(window!,
                    duration: 0.3,
                    options: .TransitionCrossDissolve,
                    animations: nil,
                    completion: nil)
            }
        }
    }
}
