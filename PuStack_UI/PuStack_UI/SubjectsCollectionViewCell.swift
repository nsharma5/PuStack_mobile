//
//  SubjectsCollectionViewCell.swift
//  PuStack_UI
//
//  Created by Aakanksha  on 16/04/17.
//  Copyright © 2017 Aakanksha . All rights reserved.
//

import UIKit

class SubjectsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var featuredImageView: UIImageView!
    
    var subject: Subject? {
        didSet{
            self.updateUI()
        }
    }
    
    private func UpdateUI(){
        if let = subject = subject {
            featuredImageView.image = subject.featuredImage
        }
        else {
            featuredImageView.image = nil
        }
    }

}
