//
//  PostsService.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/10/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import Foundation

struct PostsService {
    
    let postURL = Helper.configValue(for: "BASE_URL")
    
    func fetchPosts(completion: @escaping (PostModel?, Error?) -> ()){
        
        // Create a URL
        let urlString = "\(postURL)"
        if let url = URL(string: urlString) {
            // Create a URL Session
            let session = URLSession(configuration: .default)
            // Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                if let safeData = data {
                    if let post = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            completion(post, nil)
                        }
                    }
                }
            }// Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ postData: Data) -> PostModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PostModel.self, from: postData)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
    
}
