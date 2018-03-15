//
//  BasicTipsDetailViewController.swift
//  BeautyApp
//
//  Created by User on 09/03/16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit


class BasicTipsDetailViewController: UIViewController {
    @IBOutlet var BTekst: UITextView!
    @IBOutlet var BLabel: UILabel!
    @IBOutlet var BImage: UIImageView!
    
    
    var lLabel = ""
    var bIdeaal = ""
    var bView = UIImage(named: "")
    
    override func viewWillAppear(_ animated: Bool) {
        BTekst.text = lLabel
        BLabel.text = bIdeaal
        BImage.image = bView
        
    }

    
   override func viewDidLoad() {
        super.viewDidLoad()
   
    
    }
}
