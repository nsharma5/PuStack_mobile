//
//  ViewController.swift
//  PuStack
//
//  Created by Neha on 23/04/17.
//  Copyright © 2017 Aakanksha . All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var chapterName: UILabel!
    @IBOutlet var enrollButton: UIButton!
    @IBOutlet var videoNumber: UILabel!
    
    @IBOutlet weak var simpleProgress: UIProgressView!
    @IBOutlet weak var simpleLabel: UILabel!
    var current: Int = 0
    
    override func viewDidLoad() {
        
        func addButtonStandard (for segue: UIStoryboardSegue, sender: Any?){
            
            //dynamically allow users to access different parts of the header (navbar)
            let standard9 = UIButton(type: .custom)
            standard9.setImage(UIImage(named: "9th"), for: .normal)
            standard9.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let item1 = UIBarButtonItem(customView: standard9)
            
            let standard10 = UIButton(type: .custom)
            standard10.setImage(UIImage(named: "10th"), for: .normal)
            standard10.frame = CGRect(x: 30, y: 0, width: 30, height: 30)
            let item2 = UIBarButtonItem(customView: standard10)
            
            let standard11 = UIButton(type: .custom)
            standard11.setImage(UIImage(named: "11th"), for: .normal)
            standard11.frame = CGRect(x: 60, y: 0, width: 30, height: 30)
            let item3 = UIBarButtonItem(customView: standard11)
            
            let standard12 = UIButton(type: .custom)
            standard12.setImage(UIImage(named: "12th"), for: .normal)
            standard12.frame = CGRect(x: 90, y: 0, width: 30, height: 30)
            let item4 = UIBarButtonItem(customView: standard12)
            
            
            self.navigationItem.setRightBarButtonItems([item1,item2, item3, item4], animated: true)
        }
        
        func addButtonCourses (for segue: UIStoryboardSegue, sender: Any?){
            
            //dynamically allow users to access different parts of the header (navbar)
            let lastViewed = UIButton(type: .custom)
            lastViewed.setImage(UIImage(named: "Last"), for: .normal)
            lastViewed.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let item1 = UIBarButtonItem(customView: lastViewed)
            
            let allCourses = UIButton(type: .custom)
            allCourses.setImage(UIImage(named: "All"), for: .normal)
            allCourses.frame = CGRect(x: 30, y: 0, width: 30, height: 30)
            let item2 = UIBarButtonItem(customView: allCourses)
            
            let completed = UIButton(type: .custom)
            completed.setImage(UIImage(named: "Completed"), for: .normal)
            completed.frame = CGRect(x: 60, y: 0, width: 30, height: 30)
            let item3 = UIBarButtonItem(customView: completed)
            
            self.navigationItem.setRightBarButtonItems([item1,item2, item3], animated: true)
        }
        
        //toggling videos to acccess previous and next
        func toggleVideos (for segue: UIStoryboardSegue, sender: Any?){
            
            //dynamically allow users to access different parts of the header (navbar)
            let lastViewed = UIButton(type: .custom)
            lastViewed.setImage(UIImage(named: "Previous"), for: .normal)
            lastViewed.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let item1 = UIBarButtonItem(customView: lastViewed)
            
            let allCourses = UIButton(type: .custom)
            allCourses.setImage(UIImage(named: "Next"), for: .normal)
            allCourses.frame = CGRect(x: 30, y: 0, width: 30, height: 30)
            let item2 = UIBarButtonItem(customView: allCourses)
            
            self.navigationItem.setRightBarButtonItems([item1, item2], animated: true)
        }
        
        
        //For allowing users to enroll in and save courses
        @IBAction func enrollButtonClick(sender: AnyObject) {
            
            let defaults = `NSUserDefaults`.standardUserDefaults()
            
            defaults.setObject(chapterName.text, forKey: "enrolled")
            defaults.synchronize()
            
        }
        
        
        //update password
        @IBAction func updatePasswordBtn(sender: AnyObject) {
            
            
            PFUser.logInWithUsernameInBackground(PFUser.currentUser()!.username!, password: currentPassword.text) {
                (user:PFUser?, error:NSError?) -> Void in
                
                if error == nil {
                    
                    
                    var passwordCheckQuery = PFQuery(className: "_User")
                    passwordCheckQuery.whereKey("username", equalTo: PFUser.currentUser()!.username!)
                    var objects = passwordCheckQuery.findObjects()
                    
                    
                    for object in objects! {
                        
                        if self.newPassword.text == self.retypeNewPassword.text {
                            
                            var query6 = PFUser.query()
                            
                            query6!.whereKey("username", equalTo: PFUser.currentUser()!.username!)
                            
                            
                            query6!.findObjectsInBackgroundWithBlock {
                                
                                (objects: [AnyObject]?, error: NSError?) -> Void in
                                
                                for object6 in objects! {
                                    
                                    var ob6:PFObject = object6 as! PFObject
                                    
                                    ob6["password"] = self.newPassword.text
                                    
                                    ob6.save()
                                    
                                    println("")
                                    
                                }
                                
                            }
                            
                        }
                            
                        else {  println("")
                        }
                    }
                    
                } else {
                    
                    println("")
                }
                
            }
            
        }
        
        func loadDefaults() {
            let defaults = `NSUserDefaults`.standardUserDefaults()
            chapterName.text = defaults.objectForKey("chapterName") as String
        }
        
        
        // To add videos to storyboard dynamically
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            //let destination = segue.destination as!
            //AVPlayerViewController
            //let url = URL(string: "http://www.ebookfrenzy.com/ios_book/movie.mov")
        
            //if let videoURL = url {
                //destination.player = AVPlayer(url: videoURL)
            //}
        }

        //progress for videos
        @IBAction func actionTriggered(sender: AnyObject) {
            
            // Get current values.
            let i = current
            let max = 10
            
            // If we still have progress to make.
            if i <= max {
                // Compute ratio of 0 to 1 for progress.
                let ratio = Float(i) / Float(max)
                // Set progress.
                simpleProgress.progress = Float(ratio)
                // Write message.
                simpleLabel.text = "Processing \(i) of \(max)..."
                current++
            }
        }
        
        func didReceiveMemoryWarning() {
            //super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    
}
