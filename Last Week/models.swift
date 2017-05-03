3//
//  models.swift
//  PuStack
//
//  Created by Neha on 10/04/17.
//  Copyright © 2017 Aakanksha . All rights reserved.
//

import Foundation

protocol HomeModelProtocal: class {
    func itemsDownloaded(items: NSArray)
}


class HomeModel: NSObject, NSURLSessionDataDelegate {
    
    //properties
    
    weak var delegate: HomeModelProtocal!
    
    var data : NSMutableData = NSMutableData()
    
    let urlPath: String = "http://localhost:3000/api/subjects"
    
    
    func downloadItems() {
        
        let url: NSURL = NSURL(string: urlPath)!
        var session: NSURLSession!
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let task = session.dataTaskWithURL(url)
        
        task.resume()
        
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        self.data.appendData(data)
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            print("Failed to download data")
        }
        else {
            print("Data downloaded")
            self.parseJSON()
        }
        
    }
    

    //this function allows users to edit their account information and store it successfully so that users can use the new information successfully.
    
    func saveTapped(){
        
        if ((updateEmail.text != "" || updateFullName.text != "") && (updateEmail.text != nil || updateFullName.text != nil)){
            
            let userRef = URLSession().reference().child("users").child(URLSession().auth()!.currentUser!.uid)
            if let new_Email = updateEmail.text as? String{
                
                URLSession().auth()!.currentUser!.updateEmail(updateEmail.text!) {
                    
                    if error == nil{
                        userRef.updateChildValues(["email" : new_Email ], withCompletionBlock: {(errEM, referenceEM)   in
                            
                            if errEM == nil{
                                print(referenceEM)
                            }else{
                                print(errEM?.localizedDescription)
                            }
                        })
                    }
                }{
                    self.saveTapped("Email couldn't be updated")
                }
            }
            
            
            if let new_Name = updateFullName.text as? String{
                
                userRef.updateChildValues(["username" : new_Name ], withCompletionBlock: {(errNM, referenceNM)   in
                    
                    if errNM == nil{
                        print(referenceNM)
                    }else{
                        print(errNM?.localizedDescription)
                    }
                })
            }
            
        }else{
            
            self.saveTapped("")
            
        }
    }


    //can be used to log in and also create new accounts. Clubbed two functions from last time.
    func LogInData (_userInfo:UserInfo) -> Bool {
        let drop = Droplet()
        do {
            // Connect to the MongoDB server
            let mongoDatabase = try Database(mongoURL: "mongodb://testuser1:testuser1!@cluster0-shard-00-00-ufyzn.mongodb.net:27017,cluster0-shard-00-01-ufyzn.mongodb.net:27017,cluster0-shard-00-02-ufyzn.mongodb.net:27017/Mobile?ssl=true&replicaSet=Cluster0-shard-0&authSource=admin")
            // Select a database and collection
            let users = mongoDatabase["users"]
            drop.get("/users") { request in
                // Check if there is a Vapor session.. Should always be the case
                let session = try request.session()
                // Find the user's ID if there is any
                if let userID = session.data["user"]?.string {
                    // Check if the user is someone we know
                    guard let userDocument = try users.findOne(matching: "_id" == ObjectId(userID)) else {
                        // If we don't know the user (should never occur)
                        return ""
                    }
                    // If we know the user
                    return ""
                }
                // If the user has sent his username and password over POST, PUT, GET
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
                            return "Unable to sign up"
                        }
                        session.data["user"] = Node.string(id.string ?? "")
                        return "Thanks for signing up!"
                    }
                    // try to log in the user
                    guard let user = try users.findOne(matching: "username" == username && "password" == passwordHash), let userId = user["_id"] as String? 
                        else {
                            return "Some of the information seems wrong"
                    }
                    // Create a session for this user
                    session.data["user"] = Node.string(userId)
                    return ""
                }
                // If there is no submitted username or password AND the user isn't logged in
                return ""
            }
            drop.run()
        } catch {
            print("Cannot connect to MongoDB")
        }
    };
    
    func countUp ()
    {
    int; targetNumber = yourNumber;
    int; currentNumber = [[myLabel, text], intValue];
    single; increment = (currentNumber + 1);
 }
    
    func countDown ()
    {
        int; targetNumber = yourNumber;
        int; currentNumber = [[myLabel, text], intValue];
        single; increment = (currentNumber - 1);
    }
    
    func logOutData (_userInfo:UserInfo) -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = HomeViewController()
        
        appDelegate.window!.rootViewController = rootViewController
        appDelegate.window!.makeKeyAndVisible()
    };


}
