//
//  DIYDetailViewController.swift
//  BeautyApp
//
//  Created by  Sayed on 11-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit

class DIYDetailViewController: UIViewController {
    
    @IBOutlet var titel: UILabel!
    @IBOutlet var imageDetailView: PFImageView!
    @IBOutlet var textField: UITextView!
    
    var lLabel = ""
    var bIdeaal = ""
    var bView = UIImage(named: "")
    
        override func viewWillAppear(_ animated: Bool) {
            titel.text = lLabel
            textField.text = bIdeaal
            imageDetailView.image = bView
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("doityourself")
    }
    
}
