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
    static let appContentStyle = UIContentStyle.Dark
    
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
}