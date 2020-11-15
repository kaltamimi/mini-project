//
//  PostModel.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/10/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class PostModel: Object, Codable {
    
    @objc dynamic var id : String? = ""
    dynamic var postList = List<PostItem>()
    
    private enum CodingKeys : String, CodingKey {
        case postList = "posts"
        case id = "id"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

class PostItem: Object, Codable {
    
    @objc dynamic var id : String? = ""
    @objc dynamic var type : String? = ""
    @objc dynamic var isShare : Bool = false
    @objc dynamic var sharedPostsCount : Int = 0
    @objc dynamic var ownerUser : OwnerUser?
    @objc dynamic var amountLikes : Int = 0
    @objc dynamic var amountComments : Int = 0
    @objc dynamic var createdAt : String? = ""
    @objc dynamic var isLiked : Bool = false
    @objc dynamic var body : String? = ""
    @objc dynamic var file : File?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case isShare = "is_share"
        case sharedPostsCount = "shared_posts_count"
        case ownerUser = "owner_user"
        case amountLikes = "amount_likes"
        case amountComments = "amount_comments"
        case createdAt = "created_at"
        case isLiked = "is_liked"
        case body = "body"
        case file = "file"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        isShare = try container.decode(Bool.self, forKey: .isShare)
        sharedPostsCount = try container.decodeIfPresent(Int.self, forKey: .sharedPostsCount) ?? 0
        ownerUser = try container.decodeIfPresent(OwnerUser.self, forKey: .ownerUser)
        amountLikes = try container.decodeIfPresent(Int.self, forKey: .amountLikes) ?? 0
        amountComments = try container.decodeIfPresent(Int.self, forKey: .amountComments) ?? 0
        createdAt = try container.decode(String.self, forKey: .createdAt)
        if let liked = try container.decodeIfPresent(Bool.self, forKey: .isLiked){
            isLiked = liked
        }
        body = try container.decodeIfPresent(String.self, forKey: .body)
        file = try container.decodeIfPresent(File.self, forKey: .file)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

class OwnerUser: Object, Codable {
  
    @objc dynamic var type : String? = ""
    @objc dynamic var name : String? = ""
    @objc dynamic var avatarUrl : String? = ""
    @objc dynamic var firstName : String? = ""
    @objc dynamic var lastName : String? = ""
    @objc dynamic var id : String? = ""
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case name = "name"
        case avatarUrl = "avatar_url"
        case firstName = "first_name"
        case lastName = "last_name"
        case id = "id"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

class File : Object, Codable {
    
    @objc dynamic var id : String? = ""
    @objc dynamic var type : String? = ""
    dynamic var thumbnails = List<String>()
    @objc dynamic var thumbnail : String? = ""
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case thumbnails = "thumbnails"
        case thumbnail = "thumbnail"
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
        
        if let thumbnailsArray = try container.decodeIfPresent(Array<String>.self, forKey: .thumbnails){
            thumbnails.append(objectsIn: thumbnailsArray)
        }
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}



