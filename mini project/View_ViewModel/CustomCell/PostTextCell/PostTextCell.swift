//
//  PostTextCell.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/13/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import UIKit

class PostTextCell: BasePostCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func configure(creatorName: String?, creatorImage: String?, createdAt: String, postTitle: String?, likesNumber: Int?, commentsNumber: Int?, sharesNumber: Int?, isLiked: Bool ,postFile: File?){
        super.configure(creatorName: creatorName ?? "", creatorImage: creatorImage ?? "", createdAt: createdAt , postTitle: postTitle ?? "", likesNumber: likesNumber ?? 0, commentsNumber: commentsNumber ?? 0, sharesNumber: sharesNumber ?? 0, isLiked: isLiked, postFile: File())
    }
    
}
