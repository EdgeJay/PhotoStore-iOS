//
//  HomeViewController.swift
//  PhotoStore
//
//  Created by Wu Huijie on 9/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        validateParseUser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}
