//
//  PostImageCell.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/12/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import UIKit

class PostImageCell: BasePostCell {
    
    @IBOutlet weak var postImage: UIImageView!
    
    var postFile: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func configure(creatorName: String?, creatorImage: String?, createdAt: String, postTitle: String?, likesNumber: Int?, commentsNumber: Int?, sharesNumber: Int?, isLiked: Bool,postFile: File?){
        self.postFile = postFile?.thumbnail ?? postFile?.thumbnails[0]
        super.configure(creatorName: creatorName ?? "", creatorImage: creatorImage ?? "", createdAt: createdAt , postTitle: postTitle ?? "", likesNumber: likesNumber ?? 0, commentsNumber: commentsNumber ?? 0, sharesNumber: sharesNumber ?? 0, isLiked: isLiked, postFile: postFile ?? File())
        
        loadImageWith(urlString: self.postFile ?? "", image: self.postImage, placeholderImage: UIImage())
    }
    
    
}
