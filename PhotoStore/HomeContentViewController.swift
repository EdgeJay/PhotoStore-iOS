//
//  HomeContentViewController.swift
//  PhotoStore
//
//  Created by Wu Huijie on 9/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit
import ChameleonFramework

protocol HomeContentViewControllerDelegate: class {
    /**
        Triggered when user requests for left side menu to be opened
    */
    func onRequestLeftMenu()
    
    /**
     Triggered when user requests for filter menu to be opened
     */
    func onRequestFilterMenu()
}

class HomeContentViewController: UIViewController {
    weak var delegate: HomeContentViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(hexString: "#cccccc")
        
        // setup nav bar
        navigationItem.title = "Your Photos"
        UIManager.setNavigationBar(navigationController?.navigationBar, tintColor: UIColor.blackColor())
        
        // setup buttons for nav bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_menu"),
            style: .Plain, target: self, action: Selector("onMenuClicked:"))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_filter"),
            style: .Plain, target: self, action: Selector("onFilterClicked:"))
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
        delegate?.onRequestLeftMenu()
    }
    
    func onFilterClicked(sender: AnyObject) {
        delegate?.onRequestFilterMenu()
    }
}
