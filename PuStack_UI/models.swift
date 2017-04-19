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
    
    
    func editUserAccount(_userInfo:UserInfo) -> Bool{
        //this function allows users to edit their account information and store it successfully so that users can use the new information successfully.
    };
    
    //can be used to log in and also create new accounts. Clubbed two functions from last time.
    func LogInData (_userInfo:UserInfo) -> Bool {
        let drop = Droplet()
        do {
            // Connect to the MongoDB server
            let mongoDatabase = try Database(mongoURL: "mongodb://localhost/mydatabase")
            // Select a database and collection
            let users = mongoDatabase["users"]
            drop.get("/") { request in
                // Check if there is a Vapor session.. Should always be the case
                let session = try request.session()
                // Find the user's ID if there is any
                if let userID = session.data["user"]?.string {
                    // Check if the user is someone we know
                    guard let userDocument = try users.findOne(matching: "_id" == ObjectId(userID)) else {
                        // If we don't know the user (should never occur)
                        return "I don't know you.."
                    }
                    // If we know the user
                    return "Welcome, \(userDocument["username"] as String? ?? "")."
                }
                // If the user has sent his username and password over POST, PUT, GET or DELETE
                if let username = request.data["username"] as String? , let password = request.data["password"] as String? {
                    let passwordHash = try drop.hash.make(password)
                    
                    // When the user wants to register
                    if request.data["register"]?.bool == true {
                        // If the username already exists
                        guard try users.count(matching: "username" == username) == 0 else {
                            return "User with that username already exists"
                        }
                        // Register the user by inserting his information in the database
                        guard let id = try users.insert(["username": username, "password": passwordHash] as Document).string else {
                            return "Unable to automatically log in"
                        }
                        session.data["user"] = Node.string(id.string ?? "")
                        return "Thank you for registering \(username). You are automatically logged in"
                    }
                    // try to log in the user
                    guard let user = try users.findOne(matching: "username" == username && "password" == passwordHash), let userId = user["_id"] as String? 
                        else {
                            return "The username or password is incorrect."
                    }
                    // Create a session for this user
                    session.data["user"] = Node.string(userId)
                    return "Your login as \(username) was successful"
                }
                // If there is no submitted username or password AND the user isn't logged in
                return "Welcome to this homepage!"
            }
            drop.run()
        } catch {
            print("Cannot connect to MongoDB")
        }
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
