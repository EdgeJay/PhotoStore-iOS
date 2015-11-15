//
//  ThemeManager.swift
//  PhotoStore
//
//  Created by Wu Huijie on 5/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit
import ChameleonFramework

class UIManager {
    static let appPrimaryColor = FlatSkyBlue()
    static let appContentStyle = UIContentStyle.Light
    
    static func setupAppTheme() {
        // Setup global theme
        Chameleon.setGlobalThemeUsingPrimaryColor(appPrimaryColor, withContentStyle: appContentStyle)
    }
    
    static func swapButtonColors(button: UIButton) {
        // no it's not a mistake, this method swaps colors on purpose
        if let titleColor = button.backgroundColor, bgColor = button.titleColorForState(.Normal) {
            button.backgroundColor = bgColor
            button.setTitleColor(titleColor, forState: .Normal)
        }
    }
    
    /**
        Sets UINavigationBar's tintColor and title text to desired color
     
        - parameter navigationBar: Target UINavigationBar
        - parameter color: Color to change to
     */
    static func setNavigationBar(navigationBar: UINavigationBar?, tintColor: UIColor?) {
        
        if let navBar = navigationBar, color = tintColor {
            navBar.tintColor = color
            
            if var titleTextAttributes = navBar.titleTextAttributes {
                titleTextAttributes[NSForegroundColorAttributeName] = color
                navBar.titleTextAttributes = titleTextAttributes
            }
            else {
                navBar.titleTextAttributes = [NSForegroundColorAttributeName: color]
            }
        }
    }
}