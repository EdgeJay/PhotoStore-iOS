//
//  EmailSignUpViewController.swift
//  PhotoStore
//
//  Created by Huijie Wu on 8/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit
import Parse
import TextFieldEffects
import FontAwesomeKit
import MaterialControls
import MBProgressHUD

class EmailSignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var btnRevealPassword: UIButton!
    @IBOutlet weak var txtEmail: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField! // original password field
    @IBOutlet weak var txtVisiblePassword: HoshiTextField! // visible password
    @IBOutlet weak var btnSignUp: MDButton!
    var passwordRevealed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        btnSignUp.enabled = false
        
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
    
    // MARK: - Sign up
    func performSignUp() {
        if !btnSignUp.enabled {
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
        hud.labelText = "Signing up..."
        
        let user = PFUser()
        user.username = txtEmail.text!
        user.password = txtPassword.text!
        user.email = txtEmail.text!
        //user["phone"] = "+6591234567" // if need to add additional info
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            hud.hide(true)
            
            let alertController = UIAlertController(
                title: "",
                message: "",
                preferredStyle: .Alert
            )
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            let continueAction = UIAlertAction(title: "Continue", style: .Default, handler: { alertAction -> Void in
                // goto home view controller
                if let navController = self.navigationController {
                    navController.performSegueWithIdentifier("GotoHome", sender: self)
                }
            })
            
            if let _ = error {
                // got error
                alertController.title = "Oops"
                alertController.message = "Something went wrong while\nsigning you up:\n\n\((error!).localizedDescription.capitalizedString)"
                alertController.addAction(okAction)
            }
            else {
                // no errors
                if success {
                    // user created
                    alertController.title = "Account created"
                    alertController.message = "Thank you for signing up!"
                    alertController.addAction(continueAction)
                }
                else {
                    // user not created
                    alertController.title = "Oops"
                    alertController.message = "Something went wrong while\nsigning you up"
                    alertController.addAction(okAction)
                }
            }
            
            // display alert dialog
            self.presentViewController(alertController, animated: true, completion: nil)
        }
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
        btnSignUp.enabled = validateForm()
        
        if textField == txtEmail {
            if !passwordRevealed {
                txtPassword.becomeFirstResponder()
            }
            else {
                txtVisiblePassword.becomeFirstResponder()
            }
        }
        else if textField == txtPassword || textField == txtVisiblePassword {
            performSignUp()
        }
        
        return false
    }
    
    // MARK: - UI actions
    func onTextChanged(sender: AnyObject) {
        btnSignUp.enabled = validateForm()
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
    
    @IBAction func onSignUp(sender: AnyObject) {
        performSignUp()
    }
}
