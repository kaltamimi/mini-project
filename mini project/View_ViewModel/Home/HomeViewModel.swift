//
//  HomeViewModel.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/10/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol{
    
    func getPosts(success: (() -> Void)?, failed: ((Error?) -> Void)?)
    var postCount: Int { get }
    func getPost(at index: Int) -> PostItem?
    func resetData()
    
}

class HomeViewModel: HomeViewModelProtocol {
    
    var posts: PostModel?
    private let postService: PostsService!
    private let localDataSource:LocalService = LocalService()
    
    init() {
        self.postService =  PostsService()
        self.posts = PostModel()
    }
    
    func getPosts(success: (() -> Void)?, failed: ((Error?) -> Void)?){
        
        self.postService.fetchPosts(completion: { [weak self] (postResult, error) in
            
            if let error = error {
                
                self?.localDataSource.retrieve(from: PostModel.self, filterBy: nil) { (result, objects) in
                    if let objects = objects, objects.count > 0 {

                        self?.posts = objects[0] as? PostModel
                        success?()
 
                    } else {
                        print(error.localizedDescription)
                        failed?(error)
                    }
                }
            }
            else {
                if let postResult = postResult{
                    self?.posts = postResult
                    self?.localDataSource.save(objects: [postResult])
                    success?()
                }
            }
        })
    }
    
    var postCount: Int {
        return posts?.postList.count ?? 0
    }
    
    func getPost(at index: Int) -> PostItem? {
        guard let postList = posts?.postList else {
            return nil
        }
        return postList[index]
    }
    
    func resetData(){
        self.posts = nil
    }
    
}

