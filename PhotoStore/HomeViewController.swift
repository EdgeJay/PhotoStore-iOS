//
//  HomeViewController.swift
//  PhotoStore
//
//  Created by Wu Huijie on 9/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit
import Parse
import LGSideMenuController

class HomeViewController: LGSideMenuController {
    
    var homeLeftMenuViewController: HomeLeftMenuViewController?
    var homeContentViewController: HomeContentViewController?
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        validateParseUser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Initialization
    /**
     Main initialization block
     */
    func initialize() {
        // setup side menus
        homeLeftMenuViewController = HomeLeftMenuViewController(
            nibName: "HomeLeftMenuViewController",
            bundle: NSBundle.mainBundle())
        homeContentViewController = HomeContentViewController(
            nibName: "HomeContentViewController",
            bundle: NSBundle.mainBundle())
        let homeNavController = HomeNavigationControllerViewController(rootViewController: homeContentViewController!)
        
        self.rootViewController = homeNavController
        
        // side menu
        setLeftViewEnabledWithWidth(250.0,
            presentationStyle: LGSideMenuPresentationStyleScaleFromBig,
            alwaysVisibleOptions: LGSideMenuAlwaysVisibleOnNone)
        leftViewStatusBarStyle = .Default
        leftViewStatusBarVisibleOptions = LGSideMenuStatusBarVisibleOnAll
        leftView().addSubview(homeLeftMenuViewController!.view)
    }
    
    // MARK: - Parse
    /**
    Attempts to find current Parse user from disk and validates its session token.
    If user is found and validation passes, user will be redirected to `HomeViewController`
    */
    func validateParseUser() {
        guard let _ = PFUser.currentUser() else {
            // user not found
            return
        }
        
        guard let _ = PFUser.currentUser()?.sessionToken else {
            // session token not found
            return
        }
        
        let user = PFUser.currentUser()!
        if let emailVerified = user["emailVerified"] as? Bool {
            // make sure emailVerified = true
            if emailVerified {
                print("email verified")
            }
            else {
                // email not verified
                showEmailNotVerifiedAlert()
            }
        }
        else {
            // emailVerified is nil
            showEmailNotVerifiedAlert()
        }
    }
    
    // MARK: - Alerts
    func showEmailNotVerifiedAlert() {
        let alertController = UIAlertController(
            title: "Verify your email",
            message: "Please check your inbox for verification email. You will not be able to access certain app features while email is unverified.",
            preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Layout
    override func leftViewWillLayoutSubviewsWithSize(size: CGSize) {
        super.leftViewWillLayoutSubviewsWithSize(size)
        homeLeftMenuViewController?.view.frame = CGRectMake(0.0, 0.0, size.width, size.height)
    }
}
