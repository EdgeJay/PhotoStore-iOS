//
//  HomeLeftMenuViewController.swift
//  PhotoStore
//
//  Created by Wu Huijie on 9/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD
import FontAwesomeKit

protocol HomeLeftMenuViewControllerDelegate {
    func onRequestSettings()
    func onRequestSignOut()
}

class HomeLeftMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "MenuCell"
    let menuItems: [String] = ["Settings", "Sign Out"]
    var delegate: HomeLeftMenuViewControllerDelegate?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // setup tableview
        tableView.backgroundColor = UIColor.clearColor()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI actions
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
    
    func signOut() {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            hud.hide(true)
            self.delegate?.onRequestSignOut()
        }
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            // title
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
            cell?.textLabel?.textColor = UIColor.whiteColor()
            // status label
            cell?.detailTextLabel?.textColor = UIColor.whiteColor()
            cell?.backgroundColor = UIColor.clearColor()
        }
        
        cell?.textLabel?.text = menuItems[indexPath.row]
        
        if indexPath.row == 0 {
            if let user = PFUser.currentUser() {
                let emailVerified = user["emailVerified"]
                if emailVerified == nil {
                    cell?.detailTextLabel?.attributedText = FAKFontAwesome.exclamationCircleIconWithSize(15.0).attributedString()
                }
                else {
                    if !(emailVerified as! Bool) {
                        cell?.detailTextLabel?.attributedText = FAKFontAwesome.exclamationCircleIconWithSize(15.0).attributedString()
                    }
                }
            }
        }
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 0 {
            
        }
        else if indexPath.row == 1 {
            // sign out
            showSignOutAlert()
        }
    }
}
