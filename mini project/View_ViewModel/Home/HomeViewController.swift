//
//  HomeViewController.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/10/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelProtocol = HomeViewModel()
    var tableView = UITableView()
    
    private let refreshControl = SKRefreshControl()
    var isLoadingData: Bool = false
    
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        configureTableView()
        getPosts(withLoader: true)
        
        //Handle Keyboard Dismiss
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Setup
    func configureTableView(){
        
        view.addSubview(tableView)
        
        //Set Constrains
        tableView.pin(to: view)
        tableView.contentInsetAdjustmentBehavior = .never
        
        //Styling TableView
        tableView.backgroundColor = ColorPalette.graybg.color
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        // tableView.keyboardDismissMode = .onDrag
        
        //Register cells
        tableView.register(PostTextCell.self)
        tableView.register(PostImageCell.self)
        tableView.register(PostVideoCell.self)
        
        //Set delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    func setUpNavigation() {
        navigationItem.title = getLocalizedString(localizedKey: .header)
        self.navigationController?.navigationBar.barTintColor = ColorPalette.graybg.color
        self.navigationController?.navigationBar.isTranslucent = false
        
    }
    
    // MARK: - Call API
    func getPosts(withLoader: Bool = false){
        
        if !withLoader{
            _ = SKPreloadingView.show()
        }
        isLoadingData = true
        viewModel.getPosts(success: { [weak self] in
            
            self?.tableView.reloadData()
            SKPreloadingView.hide()
            self?.refreshControl.endRefreshing()
            self?.isLoadingData = false
            
        }) { (error) in
            
            SKPreloadingView.hide()
            self.refreshControl.endRefreshing()
            self.isLoadingData = false
            self.view.showToast(message: getLocalizedString(localizedKey: .somethingWrong))
        }
    }
    
    @objc func pullToRefresh(){
        self.viewModel.resetData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.getPosts(withLoader: true)
    }
    
}

