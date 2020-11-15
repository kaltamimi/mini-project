//
//  HomeTableViewExtension.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/10/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import UIKit
import AVKit

// MARK: - TableViewDelegate and TableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row > viewModel.postCount { return UITableViewCell() }
        let post = viewModel.getPost(at: indexPath.row)
        let type = PostType(rawValue: post?.type ?? "")
        
        switch type {
        case .text:
            let cell: PostTextCell = tableView.dequeueReusableCell(at: indexPath)
            configureBaseCell(cell, post: post ?? PostItem(), indexPath: indexPath)
            return cell
            
        case .photo:
            
            let cell: PostImageCell = tableView.dequeueReusableCell(at: indexPath)
            configureBaseCell(cell, post: post ?? PostItem(), indexPath: indexPath)
            cell.shareButton.addTarget(self, action: #selector(shareHandler), for: .touchUpInside)
            
            return cell
            
        case .video:
            let cell: PostVideoCell = tableView.dequeueReusableCell(at: indexPath)
            configureBaseCell(cell, post: post ?? PostItem(), indexPath: indexPath)
            
            cell.thumbnailImageView.isUserInteractionEnabled = true
            let myGusture = MyTapGesture(target: self, action: #selector(playVideo))
            cell.playIconImage.addGestureRecognizer(myGusture)
            myGusture.videoUrl = Constant.videoUrlForTest
            
            return cell
            
        default:
            return UITableViewCell()
            
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let currentOffSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (currentOffSetY > 0 && currentOffSetY + tableView.bounds.size.height > contentHeight - 50) && !isLoadingData {
            if(viewModel.postCount > 0){
                getPosts(withLoader: false)
            }
        }
    }
    
  
}

extension HomeViewController {

    func configureBaseCell(_ cell: BasePostCell, post: PostItem, indexPath: IndexPath){
        
        cell.configure(creatorName: post.ownerUser?.name ?? "", creatorImage: post.ownerUser?.avatarUrl ?? "", createdAt: post.createdAt ?? "", postTitle: post.body ?? "", likesNumber: post.amountLikes , commentsNumber: post.amountComments , sharesNumber: post.sharedPostsCount, isLiked: post.isLiked,  postFile: post.file ?? File())
        
    }
    
    @objc func shareHandler(_ sender: UIButton){
        
        let url = viewModel.getPost(at: sender.tag)?.file?.thumbnail ?? viewModel.getPost(at: sender.tag)?.file?.thumbnails[0]
        let body = viewModel.getPost(at: sender.tag)?.body
        let ownerUserName = viewModel.getPost(at: sender.tag)?.ownerUser?.name
        
        
        let objectsToShare = [url ?? "", body ?? "", ownerUserName ?? ""] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        if let popOver = activityVC.popoverPresentationController {
            popOver.sourceView = sender
            
        }
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    //Create Video Player 
    @objc func playVideo(sender : MyTapGesture){
        guard let url = URL(string: sender.videoUrl) else {return}
        self.playerView = AVPlayer(url: url)
        self.playerViewController.player = playerView
        
        self.present(playerViewController, animated: true)
        self.playerViewController.player?.play()
    }
    
}


class MyTapGesture: UITapGestureRecognizer {
    var videoUrl = String()
}
