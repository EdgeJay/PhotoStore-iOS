//
//  ReplaceViewStackSegue.swift
//  PhotoStore
//
//  Created by Wu Huijie on 9/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit

class ReplaceRootSegue: UIStoryboardSegue {
    override func perform() {
        if sourceViewController is UINavigationController {
            (sourceViewController as! UINavigationController).setViewControllers([destinationViewController], animated: true)
        }
        else {
            if let navController = sourceViewController.navigationController {
                navController.setViewControllers([destinationViewController], animated: true)
            }
        }
    }
}
