//
//  models.swift
//  PuStack
//
//  Created by Aakanksha  on 10/04/17.
//  Copyright © 2017 Aakanksha . All rights reserved.
//

import Foundation

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
    var database: FMDatabase? = nil
    
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("P_mobile.sqlite"))
        }
        return sharedInstance
    };
    
    func createUserAccount(_userInfo:UserInfo) -> Bool {
        //this function enables creation of an account for a first time user.
        //this function creation of values such as full name, email address, password, phone number.
    };
    
    func editUserAccount(_userInfo:UserInfo) -> Bool{
        //this function allows users to edit their account information and store it successfully so that users can use the new information successfully.
    };
    
    func storeLogInData (_userInfo:UserInfo) -> Bool {
        //this function stores log in data of the user such as email address and password
    };
    
    func logOutData (_userInfo:UserInfo) -> Bool {
        //this function logs out the user and destroys any instances which keep track of the user's account data
        //this function also frees up any memory associated with any processes.
    };
    
    func saveCourses(_userInfo:UserInfo) -> Bool{
        //this function enables users to save any of the chapters they are interested in so that they can access it easily going forward.
    };
    
    extension saveCourses {
        //saving progres of the chapters and videos completed.
    };



