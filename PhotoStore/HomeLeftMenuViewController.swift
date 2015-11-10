//
//  HomeLeftMenuViewController.swift
//  PhotoStore
//
//  Created by Wu Huijie on 9/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit

class HomeLeftMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let menuItems: [String] = ["My Account", "Sign Out"]
    
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
        var cell = tableView.dequeueReusableCellWithIdentifier("MenuCell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "MenuCell")
            cell?.textLabel?.textColor = UIColor.whiteColor()
            cell?.tintColor = UIColor.whiteColor()
            cell?.backgroundColor = UIColor.clearColor()
        }
        
        cell?.textLabel?.text = menuItems[indexPath.row]
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
