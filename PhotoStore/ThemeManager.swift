//
//  ThemeManager.swift
//  PhotoStore
//
//  Created by Wu Huijie on 5/11/15.
//  Copyright © 2015 EdgeJay. All rights reserved.
//

import UIKit
import ChameleonFramework

class ThemeManager {
    static let appPrimaryColor = FlatSkyBlue()
    static let appContentStyle = UIContentStyle.Contrast
    
    static func setupAppTheme() {
        // Setup global theme
        Chameleon.setGlobalThemeUsingPrimaryColor(appPrimaryColor, withContentStyle: appContentStyle)
    }
}