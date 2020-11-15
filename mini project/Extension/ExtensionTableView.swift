//
//  ExtensionTableView.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/13/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import UIKit

protocol CellIdentifiable {
    static var cellIdentifier: String { get }
}


extension CellIdentifiable where Self: UITableViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: CellIdentifiable { }


extension UITableView {
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        let nib  = UINib(nibName: T.cellIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.cellIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as? T else {
            
            fatalError("Error dequeuing cell for identifier \(T.cellIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.cellIdentifier) as? T else {
            
            fatalError("Error dequeuing cell for identifier \(T.cellIdentifier)")
        }
        
        return cell
    }
}
