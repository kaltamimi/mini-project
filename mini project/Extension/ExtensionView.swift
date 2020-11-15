//
//  ExtensionView.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/10/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import UIKit
import Toast_Swift

extension UIView {
    
    func pin(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview!.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview!.bottomAnchor).isActive = true
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
}

extension UIView {
    
    func showToast (message: String, titleColor: UIColor = .white, backgroundColor: UIColor = ColorPalette.tealColor.color,position:ToastPosition = .bottom,isTapToDismissEnabled:Bool = true){
        self.hideToast()
        var style = ToastStyle()
        
        style.titleColor = titleColor
        style.backgroundColor = backgroundColor
        style.titleAlignment = .center
        style.messageAlignment = .center
        
        ToastManager.shared.style = style
        ToastManager.shared.isTapToDismissEnabled = isTapToDismissEnabled
        ToastManager.shared.isQueueEnabled = true
        //TODO: change the duration
        self.makeToast(message, duration: 0.0, position: position, style: ToastManager.shared.style)
        //Fix for hide the message after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.hideAllToasts()
        }
        
    }
    
}
