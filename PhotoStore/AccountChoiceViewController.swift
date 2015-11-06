//
//  AccountChoiceViewController.swift
//  PhotoStore
//
//  Created by Wu Huijie on 6/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit
import MaterialControls

class AccountChoiceViewController: UIViewController {

    @IBOutlet weak var btnSignUpEmail: MDButton!
    @IBOutlet weak var btnConnectFacebook: MDButton!
    @IBOutlet weak var btnConnectGoogle: MDButton!
    @IBOutlet weak var btnConnectTwitter: MDButton!
    @IBOutlet var socialMediaButtons: [MDButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for button in socialMediaButtons {
            button.setTitleColor(UIManager.appPrimaryColor, forState: .Normal)
            button.backgroundColor = UIColor.clearColor()
        }
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