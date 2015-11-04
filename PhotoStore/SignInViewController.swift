//
//  SignInViewController.swift
//  PhotoStore
//
//  Created by Wu Huijie on 4/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
        let user = PFUser()
        user.username = "HJWU123"
        user.password = "password"
        user.email = "hjwu85+user123@gmail.com"
        user["phone"] = "+6591234567"
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            guard let _ = error else {
                // no errors
                if success {
                    print("user created")
                }
                else {
                    print("user not created")
                }
                return
            }
            
            // if this portion can be reached means there's an error, do something about it
            let alertController = UIAlertController(
                title: "Uh oh",
                message: "Something went wrong while\nsigning you up\n\n\((error!).localizedDescription)",
                preferredStyle: .Alert
            )
            // set actions
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(okAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        */
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
}
