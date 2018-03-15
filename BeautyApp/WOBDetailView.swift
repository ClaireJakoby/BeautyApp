//
//  WOBDetailView.swift
//  BeautyApp
//
//  Created by Claire Jakoby on 31-03-16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit


class WOBDetailView: UIViewController {
    
    @IBOutlet var bannerView: UIImageView!
    @IBOutlet var landLabel: UILabel!
    @IBOutlet var beschrijvingIdeaal: UILabel!
    
    var lLabel : String = "No title to display :("
    var bIdeaal = ""
    var bView = UIImage(named: "Beauty.jpg")


     override func viewWillAppear(_ animated: Bool) {
        landLabel.text = lLabel
        beschrijvingIdeaal.text = bIdeaal
        bannerView.image = bView
        
    }
}
