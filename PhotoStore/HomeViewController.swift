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
import MBProgressHUD

class HomeViewController: LGSideMenuController, HomeLeftMenuViewControllerDelegate {
    
    var homeLeftMenuViewController: HomeLeftMenuViewController?
    var homeFilterViewController: HomeFilterViewController?
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        
        // setup side menu
        homeLeftMenuViewController = HomeLeftMenuViewController(
            nibName: "HomeLeftMenuViewController",
            bundle: NSBundle.mainBundle())
        // set as delegate
        homeLeftMenuViewController!.delegate = self
        // add as child view controller
        addChildViewController(homeLeftMenuViewController!)
        
        // setup filter menu
        homeFilterViewController = HomeFilterViewController(
            nibName: "HomeFilterViewController",
            bundle: NSBundle.mainBundle())
        // add as child view controller
        addChildViewController(homeFilterViewController!)
        
        // main content view
        let homeContentViewController = HomeContentViewController(
            nibName: "HomeContentViewController",
            bundle: NSBundle.mainBundle())
        
        let homeNavController = HomeNavigationController(rootViewController: homeContentViewController)
        self.rootViewController = homeNavController
        
        // side menu
        setLeftViewEnabledWithWidth(250.0,
            presentationStyle: LGSideMenuPresentationStyleScaleFromBig,
            alwaysVisibleOptions: LGSideMenuAlwaysVisibleOnNone)
        leftViewStatusBarStyle = .Default
        leftViewStatusBarVisibleOptions = LGSideMenuStatusBarVisibleOnNone
        leftView().addSubview(homeLeftMenuViewController!.view)
        
        // filter menu
        setRightViewEnabledWithWidth(200.0,
            presentationStyle: LGSideMenuPresentationStyleSlideAbove,
            alwaysVisibleOptions: LGSideMenuAlwaysVisibleOnNone)
        rightViewStatusBarStyle = .Default
        rightViewStatusBarVisibleOptions = LGSideMenuStatusBarVisibleOnAll
        rightView().addSubview(homeFilterViewController!.view)
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
    
    func signOut() {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            hud.hide(true)
            self.gotoAccountChoice()
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
    
    func showSignOutAlert() {
        let alertController = UIAlertController(
            title: "Sign Out",
            message: "Do you wish to sign out now?",
            preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (alertAction: UIAlertAction) -> Void in
            self.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "No", style: .Cancel, handler: nil))
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    func gotoAccountChoice() {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        if let navViewController = storyboard.instantiateInitialViewController() {
            if let window = UIApplication.sharedApplication().delegate?.window {
                
                // change root view controller
                window?.rootViewController = navViewController
                
                // animate
                UIView.transitionWithView(window!,
                    duration: 0.3,
                    options: .TransitionCrossDissolve,
                    animations: nil,
                    completion: nil)
            }
        }
    }
    
    func gotoPhotos() {
        // close menu
        hideLeftViewAnimated(true, completionHandler: nil)
        
        if rootNavigationController()?.viewControllers[0] is HomeContentViewController {
            return
        }
        
        // replace root view controller of HomeNavigationController
        let homeContentViewController = HomeContentViewController(
            nibName: "HomeContentViewController",
            bundle: NSBundle.mainBundle()
        )
        rootNavigationController()?.setViewControllers([homeContentViewController], animated: false)
    }
    
    func gotoSettings() {
        // close menu
        hideLeftViewAnimated(true, completionHandler: nil)
        
        if rootNavigationController()?.viewControllers[0] is SettingsViewController {
            return
        }
        
        // replace root view controller of HomeNavigationController
        let settingsViewController = SettingsViewController(
            nibName: "SettingsViewController",
            bundle: NSBundle.mainBundle()
        )
        rootNavigationController()?.setViewControllers([settingsViewController], animated: false)
    }
    
    func rootNavigationController() -> HomeNavigationController? {
        return (self.rootViewController as! HomeNavigationController)
    }
    
    // MARK: - Layout
    override func leftViewWillLayoutSubviewsWithSize(size: CGSize) {
        super.leftViewWillLayoutSubviewsWithSize(size)
        homeLeftMenuViewController?.view.frame = CGRectMake(0.0, 0.0, size.width, size.height)
    }
    
    override func rightViewWillLayoutSubviewsWithSize(size: CGSize) {
        super.rightViewWillLayoutSubviewsWithSize(size)
        homeFilterViewController?.view.frame = CGRectMake(0.0, 0.0, size.width, size.height)
    }
    
    // MARK: - HomeLeftMenuViewControllerDelegate
    func onRequestPhotos() {
        gotoPhotos()
    }
    
    func onRequestSettings() {
        gotoSettings()
    }
    
    func onRequestSignOut() {
        // sign out
        showSignOutAlert()
    }
}
