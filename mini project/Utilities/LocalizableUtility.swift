//
//  LocalizableUtility.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/10/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import UIKit


func getLocalizedString(localizedKey :LocalizedKey) -> String{
    
    let formatString = NSLocalizedString(localizedKey.rawValue, comment: "")
    
    return formatString
}


extension UITextField{
    
    func LocalizedString(_ localizedKey: LocalizedKey){
        
        self.placeholder = getLocalizedString(localizedKey: localizedKey)
    }
    
}

extension UIButton{
    
    func LocalizedString(_ localizedKey: LocalizedKey){
        
        self.setTitle(getLocalizedString(localizedKey: localizedKey) , for: .normal)
        
    }
}


extension UILabel{
    
    func LocalizedString(_ localizedKey: LocalizedKey){
        
        self.text = getLocalizedString(localizedKey: localizedKey)
        
    }
}


enum LocalizedKey: String {
    
    case header
    case writeAComment
    case likes
    case comments
    case shares
    case sharedThispost
    case somethingWrong

}
