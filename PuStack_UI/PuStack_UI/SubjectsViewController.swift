//
//  SubjectsCollectionViewController.swift
//  PuStack_UI
//
//  Created by Aakanksha  on 16/04/17.
//  Copyright © 2017 Aakanksha . All rights reserved.
//

import UIKit

class SubjectsViewController: UIViewController {
    @IBOutlet weak var collectionView:UICollectionView!
    
    var subjects = Subject.fetchSubjects()
    
}
