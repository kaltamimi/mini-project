//
//  PostVideoCell.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/13/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import UIKit
import AVKit

class PostVideoCell: BasePostCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var playIconImage: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func configure(creatorName: String?, creatorImage: String?, createdAt: String, postTitle: String?, likesNumber: Int?, commentsNumber: Int?, sharesNumber: Int?, isLiked: Bool ,postFile: File?){
        super.configure(creatorName: creatorName ?? "", creatorImage: creatorImage ?? "", createdAt: createdAt , postTitle: postTitle ?? "", likesNumber: likesNumber ?? 0, commentsNumber: commentsNumber ?? 0, sharesNumber: sharesNumber ?? 0, isLiked: isLiked, postFile: File())
        
        
        let url = URL(string: Constant.videoUrlForTest)
        self.getThumbnailFromVideoUrl(url: url!) { (thumbnailImage) in
            self.thumbnailImageView.image = thumbnailImage
        }
    }
    
    // MARK - Get thumbnail
    func getThumbnailFromVideoUrl(url: URL, completion: @escaping ((_ image :UIImage?)-> Void)){
        
        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            
            let thumbnailTime = CMTimeMakeWithSeconds(Float64(5), preferredTimescale: 100)
            
            do {
                let cgThumbImage = try  avAssetImageGenerator.copyCGImage(at: thumbnailTime, actualTime: nil)
                let thumbImage = UIImage(cgImage: cgThumbImage)
                
                DispatchQueue.main.async {
                    completion(thumbImage)
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    
}
