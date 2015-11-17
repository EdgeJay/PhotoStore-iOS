//
//  ConnectFacebookViewController.swift
//  PhotoStore
//
//  Created by Wu Huijie on 17/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import ParseFacebookUtilsV4
import MaterialControls
import MBProgressHUD

class ConnectFacebookViewController: UIViewController {
    
    @IBOutlet weak var btnConnect: MDButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Connect with Facebook"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI actions
    @IBAction func onConnect(sender: AnyObject) {
        if let user = PFUser.currentUser() {
            if !PFFacebookUtils.isLinkedWithUser(user) {
                PFFacebookUtils.linkUserInBackground(user, withReadPermissions: ["public_profile", "user_photos"], block: { (success: Bool, error: NSError?) -> Void in
                    
                    guard let _ = error else {
                        // got error
                        return
                    }
                    
                    if success {
                        
                    }
                    else {
                        
                    }
                })
            }
        }
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
