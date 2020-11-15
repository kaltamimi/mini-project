//
//  SKActivityIndicatorViewStyle.swift
//  SKActivityIndicatorView
//
//  Created by Sachin on 22/12/17.
//

import Foundation
import UIKit





// MARK: - Activity Indicator Type
@IBDesignable
class SKActivityIndicator: UIView{
    private var spinnerContainerView:UIView!
    
    var style: ActivityIndicatorStyle = .defaultSpinner{
        didSet{
            self.configure()
        }
    }
    
    var colors: [UIColor] = [.red]/*{
     //        didSet{
     //            self.configure()
     //        }
     }*/
    
    private func configure(){
        
        self.colors = [
            
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:0.08),
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:0.1),
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:0.3),
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:0.4),
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:0.55),
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:0.7),
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:0.8),
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:1)
            
        ]
        
        self.backgroundColor = .clear
        if spinnerContainerView != nil{
            spinnerContainerView.removeFromSuperview()
            spinnerContainerView = nil
        }
        
        spinnerContainerView = UIView(frame: self.bounds)
        spinnerContainerView.backgroundColor = .clear
        addSubview(spinnerContainerView)
        SKActivityIndicatorStyle.createSpinner(in: spinnerContainerView.layer, size: spinnerContainerView.layer.bounds.size, colors: colors, style: style)
    }
}



