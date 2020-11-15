//
//  BasePostCell.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/12/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import UIKit
import AlamofireImage

class BasePostCell: UITableViewCell {
    
    @IBOutlet weak var creatorName: UILabel!
    @IBOutlet weak var creatorImage: UIImageView!
    @IBOutlet weak var createdAt: UILabel!
    
    @IBOutlet weak var postTitle: UILabel!
    
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var numberOfLikeLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var numbersOfSharesLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var commentTextfield: UITextField!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var shareButton2: UIButton!
    @IBOutlet weak var numberOfShare2: UILabel!
    @IBOutlet weak var shareLabel2: UILabel!
    
    
     
    override func awakeFromNib() {
        super.awakeFromNib()

        likeLabel.text = getLocalizedString(localizedKey: .likes)
        shareLabel.text = getLocalizedString(localizedKey: .shares)
        commentsLabel.text = getLocalizedString(localizedKey: .comments)
        commentTextfield.layer.borderWidth = 0.85
        commentTextfield.layer.borderColor = ColorPalette.graybg.color.cgColor
        commentTextfield.placeholder = getLocalizedString(localizedKey: .writeAComment)
       
    }
    
    func configure(creatorName: String, creatorImage: String, createdAt: String, postTitle: String, likesNumber: Int, commentsNumber: Int, sharesNumber: Int, isLiked: Bool ,postFile: File){
        self.creatorName.text = creatorName
        self.createdAt.text = "\(Helper.getDate(date: createdAt))"
        
        if postTitle.isEmpty {
            self.postTitle.isHidden = true
        } else {
            self.postTitle.isHidden = false
            self.postTitle.text = postTitle
        }
        
        loadImageWith(urlString: creatorImage, image: self.creatorImage, placeholderImage: UIImage())
        
        configureBoardView(likeNum: likesNumber, commentNum: commentsNumber, shareNum: likesNumber)
        
        // If you want to show share view
        self.shareView.isHidden = true
        
        if isLiked {
            likeButton.imageView?.image = UIImage(named: "like")
        } else {
            likeButton.imageView?.image = UIImage(named: "unlike")
        }
        
    }
    
    
    func loadImageWith(urlString: String, image: UIImageView, placeholderImage: UIImage?, success: (() -> Void)? = nil, failed: (() -> Void)? = nil){
        guard let url = URL(string: urlString) else { return }
        
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: image.frame.size,
            radius: image.cornerRadius
        )
        
        image.af.setImage(withURL: url,
                          placeholderImage: placeholderImage,
                          filter: filter,
                          imageTransition: .crossDissolve(0.1)) { (response) in
                            if response.error != nil {
                                failed?()
                            }else{
                                success?()
                            }
        }
        
    }
    
    func configureBoardView(likeNum: Int, commentNum: Int, shareNum: Int){
        
        if likeNum <= 0 &&  commentNum <= 0 && shareNum <= 0 {
            self.boardView.isHidden = true
        } else {
            self.boardView.isHidden = false
        }
        
        if likeNum <= 0 {
            self.likeLabel.isHidden = true
            self.numberOfLikeLabel.isHidden = true
        } else {
            self.likeLabel.isHidden = false
            self.numberOfLikeLabel.isHidden = false
            self.numberOfLikeLabel.text = "(\(String(describing: likeNum)))"
        }
        
        if commentNum <= 0 {
            self.commentsLabel.isHidden = true
            self.numberOfCommentsLabel.isHidden = true
        } else {
            self.commentsLabel.isHidden = false
            self.numberOfCommentsLabel.isHidden = false
            self.numberOfCommentsLabel.text = "(\(String(describing: commentNum)))"
        }
        
        if shareNum <= 0 {
            self.shareLabel.isHidden = true
            self.numbersOfSharesLabel.isHidden = true
            
            self.shareLabel2.isHidden = true
            self.numberOfShare2.isHidden = true
            
        } else {
            self.shareLabel.isHidden = false
            self.numbersOfSharesLabel.isHidden = false
            self.numbersOfSharesLabel.text = "(\(String(describing: shareNum)))"
            
            self.shareLabel2.isHidden = false
            self.numberOfShare2.isHidden = false
            self.numberOfShare2.text = "(\(String(describing: shareNum)))"
        }

    }
    
}

