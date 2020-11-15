//
//  SKRefreshControl.swift
//
//  Created by Moayad Al kouz on 9/25/18.
//

import UIKit
import AudioToolbox

class SKRefreshControl: UIRefreshControl {
    
    
    //MARK: - Properties
    var spinnerColors: [UIColor]{
        return [
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:0.08),
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:0.1),
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:0.3),
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:0.4),
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:0.55),
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:0.7),
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:0.8),
            UIColor(red: 0.088, green: 0.693, blue: 0.705, alpha:1)
        ]
    }
    
    private var spinnerView: SKActivityIndicator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override init() {
        super.init()
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let spinner = self.spinnerView else {
            return
        }
        spinner.center.x = self.center.x
    }
    
    //MARK: - Helper Methods
    
    private func configureView(){
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        self.spinnerView = SKActivityIndicator(frame: CGRect(x: 0, y: 10, width: 40, height: 40))
        //        spinnerView?.frame = CGRect(x: 0, y: 10 , width: 40, height: 40)
        self.tintColor = .clear
        self.spinnerView!.center.x = self.center.x
        self.subviews.first?.alpha = 0
        
        spinnerView!.colors = self.spinnerColors
        spinnerView!.style = .spinningFadeCircle
        
        self.addSubview(spinnerView!)
        self.sendSubviewToBack(spinnerView!)
        
    }
    
    func beginRefreshingManually(completion: (() -> (Void))? ) {
        UIView.animate(withDuration: 0.3, animations: {
            if let scrollView = self.superview as? UIScrollView {
                scrollView.setContentOffset(CGPoint(x: 0, y: -scrollView.contentInset.top - self.frame.height), animated: false)
            }
        }) { (completed) in
            if completed{
                completion?()
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                
                self.beginRefreshing()
                self.sendActions(for: .valueChanged)
            }
        }
        
        
        
    }
    
    
}
