//
//  SignInViewController.swift
//  PhotoStore
//
//  Created by Wu Huijie on 4/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit
import Parse
import TextFieldEffects
import FontAwesomeKit
import MaterialControls

class SignInViewController: UIViewController {
    
    @IBOutlet weak var btnForgotPassword: MDButton!
    @IBOutlet weak var btnRevealPassword: UIButton!
    @IBOutlet weak var txtEmail: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField! // original password field
    @IBOutlet weak var txtVisiblePassword: HoshiTextField! // visible password
    var passwordRevealed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnForgotPassword.backgroundColor = UIColor.clearColor()
        
        btnRevealPassword.backgroundColor = UIColor.clearColor()
        btnRevealPassword.alpha = 0.3
        btnRevealPassword.setAttributedTitle(FAKFontAwesome.eyeIconWithSize(15.0).attributedString(), forState: .Normal)
        
        txtVisiblePassword.hidden = true
        
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
    
    @IBAction func onRevealPassword(sender: AnyObject) {
        if passwordRevealed {
            btnRevealPassword.alpha = 0.3
            txtPassword.hidden = false
            txtPassword.text = txtVisiblePassword.text
            txtVisiblePassword.hidden = true
        }
        else {
            btnRevealPassword.alpha = 1.0
            txtPassword.hidden = true
            txtVisiblePassword.text = txtPassword.text
            txtVisiblePassword.hidden = false
        }
        
        passwordRevealed = !passwordRevealed
    }
}
