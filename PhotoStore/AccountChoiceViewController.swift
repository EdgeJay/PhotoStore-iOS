//
//  AccountChoiceViewController.swift
//  PhotoStore
//
//  Created by Wu Huijie on 6/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit
import Parse
import MaterialControls
import MBProgressHUD

class AccountChoiceViewController: UIViewController {

    @IBOutlet weak var btnSignInEmail: UIBarButtonItem!
    @IBOutlet weak var btnSignUpEmail: MDButton!
    @IBOutlet weak var btnTryAsGuest: MDButton!
    @IBOutlet var dividerViews: [UIView]!
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnTryAsGuest.setTitleColor(UIManager.appPrimaryColor, forState: .Normal)
        btnTryAsGuest.backgroundColor = UIColor.clearColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        showButtons(false);
        validateParseUser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showButtons(show: Bool) {
        navigationController?.setNavigationBarHidden(!show, animated: true)
        btnSignUpEmail.hidden = !show
        btnTryAsGuest.hidden = !show
        
        for view in dividerViews {
            view.hidden = !show
        }
    }
    
    // MARK: - Parse
    /**
        Attempts to find current Parse user from disk and validates its session token.
        If user is found and validation passes, user will be redirected to `HomeViewController`
    */
    func validateParseUser() {
        guard let _ = PFUser.currentUser() else {
            showButtons(true)
            return
        }
        
        guard let _ = PFUser.currentUser()?.sessionToken else {
            showButtons(true)
            return
        }
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        PFUser.becomeInBackground((PFUser.currentUser()?.sessionToken)!, block: { (user: PFUser?, error: NSError?) -> Void in
            // user found
            hud.hide(true)
            self.gotoHome()
        })
    }
    
    // MARK: - Navigation
    /**
        Goto `HomeViewController`
    */
    func gotoHome() {
        (navigationController as? NavigationController)?.gotoHome()
    }
}
