//
//  LocalContext.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/11/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import RealmSwift
import Realm

protocol LocalServiceProtocol {
    
    func save(objects: [Object], completion: ((Any?) -> ())?)
    func retrieve(from type: Object.Type, filterBy: NSPredicate?, completion: (Any?, [Object]?) -> ())
    
}

class LocalService: LocalServiceProtocol {

    public static var shared = LocalService()
    private var realm: Realm!

     /// Insert an object in local storage. If the object exists then update the whole object.
     ///
     /// - Parameters:
     ///   - objects: an Array of Realm Objects
     ///   - completion: a callback function that is invoked when the operation is completed. The function returns true when the operation
     ///                    is successful, and NSError object when the operation has failed.
     func save(objects: [Object], completion: ((Any?) -> ())? = nil){
         do {
             self.realm = try Realm()
             try realm.write {
                 objects.forEach({ (object) in
                     realm.add(object, update: .all)
                 })
                 completion?(true)
             }
         }catch(let error as NSError){
             print("Error occured while upserting an object. In \(self), \(#function), \(#line)")
             print("Error: \(error.localizedDescription)")
             completion?(error)
         }
     }
     
     /// Retrieves a list of Objects from local storage.
     ///
     /// - Parameters:
     ///   - type: Object type (e.g. Center.self)
     ///   - filterBy: NSPredicate, optional wil nil as default value
     ///   - completion: a callback function that is invoked when the operation is completed. The function returns true and an array of Object when the operation
     ///                    is successful, and NSError object when the operation has failed.
     func retrieve(from type: Object.Type, filterBy: NSPredicate? = nil, completion: (Any?, [Object]?) -> ()){
         do {
             self.realm = try Realm()
             let result = filterBy == nil ? Array(realm.objects(type.self)) : Array(realm.objects(type.self).filter(filterBy!))
           completion(true, result)
  
         } catch(let error as NSError){
             print("Error occured while upserting an object. In \(self), \(#function), \(#line)")
             print("Error: \(error.localizedDescription)")
             completion(error, nil)
         }
     }
}
