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

protocol HomeLeftMenuViewControllerDelegate: class {
    func onRequestPhotos()
    func onRequestSettings()
    func onRequestSignOut()
}

class HomeLeftMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "MenuCell"
    let menuItems: [String] = ["Your Photos", "Settings", "Sign Out"]
    weak var delegate: HomeLeftMenuViewControllerDelegate?
    
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
        
        if let settingsIndex = menuItems.indexOf("Settings") {
            if indexPath.row == settingsIndex {
                if let user = PFUser.currentUser() {
                    
                    let emailVerified = user["emailVerified"]
                    let exclamationText = FAKFontAwesome.exclamationCircleIconWithSize(15.0).attributedString()
                    
                    if emailVerified == nil {
                        cell?.detailTextLabel?.attributedText = exclamationText
                    }
                    else {
                        if !(emailVerified as! Bool) {
                            cell?.detailTextLabel?.attributedText = exclamationText
                        }
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
            self.delegate?.onRequestPhotos()
        }
        else if indexPath.row == 1 {
            self.delegate?.onRequestSettings()
        }
        else if indexPath.row == 2 {
            self.delegate?.onRequestSignOut()
        }
    }
}
