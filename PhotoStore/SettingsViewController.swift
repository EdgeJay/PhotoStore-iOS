//
//  SettingsViewController.swift
//  PhotoStore
//
//  Created by Huijie Wu on 15/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit
import LGSideMenuController

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Settings"
        
        // setup buttons for nav bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_menu"),
            style: .Plain, target: self, action: Selector("onMenuClicked:"))
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
    
    // MARK: - UI actions
    func onMenuClicked(sender: AnyObject) {
        (navigationController?.parentViewController as? LGSideMenuController)?.showLeftViewAnimated(true, completionHandler: nil)
    }
}
