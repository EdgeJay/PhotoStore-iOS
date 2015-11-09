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
import MBProgressHUD

class EmailSignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var btnForgotPassword: MDButton!
    @IBOutlet weak var btnRevealPassword: UIButton!
    @IBOutlet weak var txtEmail: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField! // original password field
    @IBOutlet weak var txtVisiblePassword: HoshiTextField! // visible password
    @IBOutlet weak var btnSignIn: MDButton!
    var passwordRevealed = false
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnForgotPassword.backgroundColor = UIColor.clearColor()
        btnRevealPassword.backgroundColor = UIColor.clearColor()
        btnRevealPassword.alpha = 0.3
        btnRevealPassword.setAttributedTitle(FAKFontAwesome.eyeIconWithSize(15.0).attributedString(), forState: .Normal)
        
        txtVisiblePassword.hidden = true
        txtEmail.addTarget(self, action: Selector("onTextChanged:"), forControlEvents: .EditingChanged)
        txtEmail.delegate = self
        txtPassword.addTarget(self, action: Selector("onTextChanged:"), forControlEvents: .EditingChanged)
        txtPassword.delegate = self
        txtVisiblePassword.addTarget(self, action: Selector("onTextChanged:"), forControlEvents: .EditingChanged)
        txtVisiblePassword.delegate = self
        
        btnSignIn.enabled = false
        
        // need to add constraints for content view
        let leftConstraint = NSLayoutConstraint(item: contentView,
            attribute: .Leading,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Leading,
            multiplier: 1.0,
            constant: 20)
        let rightConstraint = NSLayoutConstraint(item: view,
            attribute: .Trailing,
            relatedBy: .Equal,
            toItem: contentView,
            attribute: .Trailing,
            multiplier: 1.0,
            constant: 20)
        view.addConstraints([leftConstraint, rightConstraint])
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
    
    // MARK: - Login
    func performSignIn() {
        if !btnSignIn.enabled {
            return
        }
        
        // hide password if revealed
        if passwordRevealed {
            togglePasswordVisibility()
        }
        
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
        txtVisiblePassword.resignFirstResponder()
        
        // display progress
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "Signing in..."
        
        PFUser.logInWithUsernameInBackground(txtEmail.text!, password: txtPassword.text!, block: { (user: PFUser?, error: NSError?) -> Void in
            // dismiss progress display
            hud.hide(true)
            
            if user != nil {
                if let navController = self.navigationController {
                   navController.performSegueWithIdentifier("GotoHome", sender: self)
                }
            }
            else {
                // login failed, show error
                let alertController = UIAlertController(
                    title: "Uh oh",
                    message: "Something went wrong while\nsigning you in:\n\n\((error!).localizedDescription.capitalizedString)",
                    preferredStyle: .Alert
                )
                
                // set actions
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(okAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        })
    }
    
    // MARK: - Form validation
    func validateForm() -> Bool {
        guard let _ = txtEmail.text, _ = (passwordRevealed ? txtVisiblePassword.text: txtPassword.text) else {
            return false
        }
        
        if NSString(string: txtEmail.text!).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).characters.count > 0 &&
            ((!passwordRevealed && NSString(string: txtPassword.text!).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).characters.count > 0) ||
                (passwordRevealed && NSString(string: txtVisiblePassword.text!).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).characters.count > 0)) {
                    
                    return true
        }
        
        return false
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        btnSignIn.enabled = validateForm()
        
        if textField == txtEmail {
            if !passwordRevealed {
                txtPassword.becomeFirstResponder()
            }
            else {
                txtVisiblePassword.becomeFirstResponder()
            }
        }
        else if textField == txtPassword || textField == txtVisiblePassword {
            performSignIn()
        }
        
        return false
    }
    
    // MARK: - UI actions
    func onTextChanged(sender: AnyObject) {
        btnSignIn.enabled = validateForm()
    }
    
    func togglePasswordVisibility() {
        if passwordRevealed {
            btnRevealPassword.alpha = 0.3
            txtPassword.hidden = false
            txtPassword.text = txtVisiblePassword.text
            txtPassword.becomeFirstResponder()
            txtVisiblePassword.hidden = true
        }
        else {
            btnRevealPassword.alpha = 1.0
            txtPassword.hidden = true
            txtVisiblePassword.text = txtPassword.text
            txtVisiblePassword.hidden = false
            txtVisiblePassword.becomeFirstResponder()
        }
        
        passwordRevealed = !passwordRevealed
    }
    
    @IBAction func onRevealPassword(sender: AnyObject) {
        togglePasswordVisibility()
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        performSignIn()
    }
}
