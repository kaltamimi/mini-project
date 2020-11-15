//
//  ColorPalette.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/10/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import UIKit

enum ColorPalette: String{
    case graybg
    case grayFont
    case tealColor
    
    var color : UIColor {
        return UIColor(named: self.rawValue)!
    }
    
}
 
