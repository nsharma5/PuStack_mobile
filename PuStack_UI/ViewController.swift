//
//  ViewController.swift
//  PuStack_UI
//
//  Created by Aakanksha  on 17/04/17.
//  Copyright © 2017 Aakanksha . All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {
    
    var myImages : NSMutableArray = NSMutableArray()
    var selectedIndex : Int!
    @IBOutlet var SlideViewHorizontal: iCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Create an image array and make sure to all these images in the project directory
        myImages = NSMutableArray(array: ["carousel1.jpg","carousel2.jpg","carousel3.jpg"])
        SlideViewHorizontal.type = iCarouselType.CoverFlow2
        SlideViewHorizontal .reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Following are the icarousel delegate methods which has to be implemented
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int
    {
        return myImages.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView
    {
        //Return an image view item
        var itemView = UIImage(named: "\(myImages.object(at: index))")
        return itemView
    }
    
    //When a user clicks on any images available in iCarousel, segue triggers programmatically.
    //Generally segue initiated automatically when a user clicks on any image from iCarousel
    func carousel(carousel: iCarousel, didSelectItemAtIndex index: Int) {
        selectedIndex = index
        self .performSegueWithIdentifier(withIdentifier: "imageDisplaySegue", sender: nil)
    }
    
    //When segue triggers, pass selected image to the destination view controller.
    //overriding prepareForSegue method
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "imageDisplaySegue")
        {
            var viewController : ImageDisplayViewController = segue.destination as! ImageDisplayViewController
            viewController.selectedImage = UIImage(named: "\(myImages.object(at: selectedIndex))")
        }
    }
    
    let button1 = UIButton(type: .custom)
    button1.setImage(UIImage(named: "button1"), for: .normal)
    button1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    button1.addTarget(self, action: #selector(Class.Methodname), for: .touchUpInside)
    let item1 = UIBarButtonItem(customView: button1)
    
    let button2 = UIButton(type: .custom)
    button2.setImage(UIImage(named: "button2"), for: .normal)
    button2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    button2.addTarget(self, action: #selector(Class.MethodName), for: .touchUpInside)
    let item2 = UIBarButtonItem(customView: button2)
    
    self.navigationItem.setRightBarButtonItems([item1,item2], animated: true)
}
